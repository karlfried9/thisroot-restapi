require 'net/http'
class Api::V1::MainController < ApplicationController
  #before_action 'authenticate_user!'
  before_action 'authenticate_token!'

  def test_action
    @user = User.find_by(email: 'ana@cerveo.com')
    render json: @user
  end

  def userapp
    mobile_number = params[:mobileNum]
    @user_app = Usersapp.find_by(mobileNum: mobile_number)
    if @user_app.nil?
      @user_app = Usersapp.new(user_app_params)
      @user_app.registrationDate = DateTime.now
      @user_app.loginCount = 0
      if @user_app.save
        render json: @user_app
      else
        render json: {status: "failure"}
      end
    else
      @user_app.lastLogin = DateTime.now
      @user_app.loginCount += 1
      if @user_app.update(user_app_params)
        render json: @user_app
      else
        render json: {status: "failure"}
      end
    end
  end

  def search_caret_properties
    params = request.params
    mobile_number = params[:mobileNum]
    query_count = params[:queryCount].nil? ? 10 : params[:queryCount].to_i
    @user_app = Usersapp.find_by(mobileNum: mobile_number)
    if @user_app.nil?
      render json: {status: "error", data: "Error"}
      return
    end
    page_number = 1
    if params[:page]
      page_number = params[:page]
    end
    @caret_properties = CaretProperty.all

    if params[:propertyId]
      @caret_properties = @caret_properties.where('id = ?', params[:propertyId])
    end

	# Mode 1 = Auto; 0 = Manual. Use appropriate fields for query type.
    if params[:mode] == "1"
    	maxBudget = @user_app.value
    	startZip = @user_app.zipcode
    	searchDist = 40    	
    end
    if params[:mode] == "0"
    	maxBudget = @user_app.maxBudget
    	startZip = @user_app.startZip
    	searchDist = @user_app.searchDist
    end
    
    # additional search fields
    @caret_properties = @caret_properties.where('ListPrice <= ?', maxBudget).select("*," + maxBudget.to_s + " - ListPrice as sub_price")
    if @user_app.metricUS == 1
      dist_param = 1
    else
      dist_param = 1.609344
    end
    if @user_app.latitude != 0 and @user_app.longitude != 0 and @user_app.searchType != '' and searchDist != 0 and startZip == ''
      @caret_properties = @caret_properties.select("(((acos(sin((" + @user_app.latitude + "*pi()/180)) *
                                                                 sin((`Latitude`*pi()/180))+cos(("+ @user_app.latitude + "*pi()/180)) *
                                                                 cos((`Latitude`*pi()/180)) * cos((("+ @user_app.longitude + "- `Longitude`)*
                                                                                                      pi()/180))))*180/pi())*60*1.1515
                                                    ) as distance" ).where('distance < ?', searchDist*dist_param)
    end

    if startZip != '' and @user_app.searchType != '' and searchDist != 0
      uri = URI('http://maps.googleapis.com/maps/api/geocode/json?address=' + startZip.to_s)
      req = Net::HTTP.get(uri)
      req = JSON.parse(req)
      if req['results'].present?
        lat = req['results'][0]['geometry']['location']['lat']
        lang = req['results'][0]['geometry']['location']['lng']
        @user_app.latitude = lat
        @user_app.longitude = lang
        @user_app.save
        if @user_app.searchType == "0"
          @caret_properties = @caret_properties.select("(((acos(sin((" + @user_app.latitude.to_s + "*pi()/180)) *
                                                                     sin((`Latitude`*pi()/180))+cos(("+ lat.to_s + "*pi()/180)) *
                                                                     cos((`Latitude`*pi()/180)) * cos((("+ lang.to_s + "- `Longitude`)*
                                                                                                          pi()/180))))*180/pi())*60*1.1515
                                                        ) as distance" ).having('distance < ?', (@user_app.searchDist*dist_param).round(2).to_s)
        else
          # Search properties by commute time
          # In this case @user_app.searchDist is just time(minutes)
          uri = URI('http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Network/ESRI_DriveTime_US/GPServer/CreateDriveTimePolygons/execute')
          input_location = "{features:[{geometry:{x:#{@user_app.longitude},y:#{@user_app.latitude},spatialReference:{wkid:4326}}}],spatialReference:{wkid:4326}}"
          polygon_params = {
              'Input_Location' => input_location,
              'Drive_Times' => searchDist,
              'f' => 'pjson',
          }
          res = Net::HTTP.post_form(uri, polygon_params)
          res = JSON.parse(res.body)
          if res['results'].present?
            polygon = res['results'][0]['value']['features'][0]['geometry']['rings'][0]
            polygon_text = "POLYGON(("
            polygon.each do |p|
              polygon_text = polygon_text + p[0].to_s + " " + p[1].to_s + ","
            end
            polygon_text = polygon_text.chomp(',') + "))"
            @caret_properties = @caret_properties.where("Contains( GeomFromText('#{polygon_text}'), GeomFromText(CONCAT('POINT(',Longitude,' ',Latitude,')')))")
          end
        end
      end
      #get directions from two points
      #"https://maps.googleapis.com/maps/api/directions/json?origin=49.515828,3.224381&destination=50.590798,30.825941"
    end

    if startZip != '' and @user_app.searchType == '' and searchDist == 0
      @caret_properties = @caret_properties.where('ZipCode = ?', startZip)
    end

    if @user_app.bedrooms != 0 and params[:mode] == "1"
      @caret_properties = @caret_properties.where('Bedrooms >= ?', @user_app.bedrooms)
    end

	  if @user_app.minBeds != 0 and params[:mode] == "0"
      @caret_properties = @caret_properties.where('Bedrooms >= ?', @user_app.minBeds).select("Bedrooms - " + @user_app.minBeds.to_s + " as sub_bed")
    end

    if @user_app.bathsFull != 0 and params[:mode] == "1"
      @caret_properties = @caret_properties.where('BathsFull >= ?', @user_app.bathsFull)
    end
    
    if @user_app.minBaths != 0 and params[:mode] == "0"
      @caret_properties = @caret_properties.where('BathsFull >= ?', @user_app.minBaths).select("BathsFull - " + @user_app.minBaths.to_s + " as sub_bath")
    end

    if @user_app.squareFootageStructure != 0
      @caret_properties = @caret_properties.where('SquareFootageStructure >= ?', @user_app.squareFootageStructure).select("SquareFootageStructure / " + @user_app.squareFootageStructure.to_s + " as div_squareFootageStructure")
    end

    if @user_app.lotSquareFootage != 0
      @caret_properties = @caret_properties.where('LotSquareFootage >= ?', @user_app.lotSquareFootage).select("LotSquareFootage / " + @user_app.lotSquareFootage.to_s + " as div_lotSquareFootage")
    end

    #if @user_app.minBeds != 0
    #  @caret_properties = @caret_properties.where('Bedrooms >= ?', @user_app.minBeds).select("Bedrooms - " + @user_app.minBeds.to_s + " as sub_bed")
    #end

    #if @user_app.minBaths != 0
    #  @caret_properties = @caret_properties.where('BathsFull >= ?', @user_app.minBaths).select("BathsFull - " + @user_app.minBaths.to_s + " as sub_bath")
    #end

    if @user_app.propTypes != '' and params[:mode] == "0"
      prop_types = @user_app.propTypes.split(",")
      @caret_properties = @caret_properties.where('PropertySubType IN(?)', prop_types)
    end

    @caret_properties = @caret_properties.where("SaleYN = 'Y'")
    #@caret_properties = @caret_properties.where("Status IN ('Active','Pending Sale','Backup Offer')")
    @caret_properties = @caret_properties.where("Status IN ('Active')")
    @caret_properties = @caret_properties.order("Propertyid")
    @user_like_dislike = UserLikeDislike.where(mobileNum: mobile_number, likeDislike: 0).map {|i| i.propertyID }
    if @user_like_dislike.present?
      @caret_properties = @caret_properties.where("Propertyid NOT IN (?)", @user_like_dislike)
    end

    # city
    @caret_properties = @caret_properties.where("City <> 'Foreign Country'")
    @caret_properties = @caret_properties.where("City NOT LIKE 'Outside Area%'")
    @caret_properties = @caret_properties.where("primaryPhoto IS NOT NULL")

    #@caret_properties = @caret_properties.paginate(:page => 2, :per_page => 2)
    # Since there are some issue for will_paginate when we use having caluse so we implement it manually.
    per_page = query_count
    @caret_properties = @caret_properties.limit(per_page)
    @caret_properties = @caret_properties.offset(per_page*(page_number.to_i-1))

    render json: @caret_properties
  end

  def like_property
    mobile_number = params[:mobileNum]
    @user_like_dislike = UserLikeDislike.find_by(mobileNum: mobile_number, propertyID: params[:propertyID])
    if @user_like_dislike.nil?
      @user_like_dislike = UserLikeDislike.new(user_like_dislike_params)
    else
      @user_like_dislike.likeDislike = params[:likeDislike]
      #@user_like_dislike.rejectReasons = params[:rejectReasons]
      @user_like_dislike.update(user_like_dislike_params)
    end
    if @user_like_dislike.save
      render json: @user_like_dislike
    else
      render json: {status: "error", data: "Error"}
    end
  end

  def clear_user_like
    mobile_number = params[:mobileNum]
    @user_like_dislikes = UserLikeDislike.where(mobileNum: mobile_number)

    if params[:likeDislike].present?
      #like = params[:likeDislike] == "0" ? TRUE : FALSE
      @user_like_dislikes = @user_like_dislikes.where(likeDislike: params[:likeDislike])

      if params[:propertyID].present?
        property_ids = params[:propertyID].split(",")
        if property_ids.count > 0
          @user_like_dislikes = @user_like_dislikes.where(propertyID: property_ids)
        end
      end
      @user_like_dislikes.each do |like_property|
        like_property.destroy
      end
    end
    render json: {status: "success", data: "success"}
  end

  def user_liked_properties
    mobile_number = params[:mobileNum]
    @user_like_dislike = UserLikeDislike.where(mobileNum: mobile_number, likeDislike: 1).map {|i| i.propertyID }
    @caret_properties = CaretProperty.where("Propertyid IN (?)", @user_like_dislike)
    render json: @caret_properties
  end

  def search_caret_photos
    matrix_id = params[:matrixID]
    if matrix_id.nil?
      render json: {status: "error", data: "Error"}
    end
    @caret_photos = CaretPhoto.where(:matrix_id => matrix_id).select("url")
    render json: @caret_photos
  end

  def get_polygon
    mobile_number = params[:mobileNum]
    query_count = params[:queryCount].nil? ? 10 : params[:queryCount].to_i
    @user_app = Usersapp.find_by(mobileNum: mobile_number)
    if @user_app.nil?
      render json: {status: "error", data: "Error"}
      return
    end

    if @user_app.startZip != '' and @user_app.searchType != '' and @user_app.searchDist != 0
      uri = URI('http://maps.googleapis.com/maps/api/geocode/json?address=' + @user_app.startZip)
      req = Net::HTTP.get(uri)
      req = JSON.parse(req)
      if req['results'].present?
        lat = req['results'][0]['geometry']['location']['lat']
        lang = req['results'][0]['geometry']['location']['lng']
        @user_app.latitude = lat
        @user_app.longitude = lang
        @user_app.save
        if @user_app.searchType == "1"
          # Search properties by commute time
          # In this case @user_app.searchDist is just time(minutes)
          uri = URI('http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Network/ESRI_DriveTime_US/GPServer/CreateDriveTimePolygons/execute')
          input_location = "{features:[{geometry:{x:#{@user_app.longitude},y:#{@user_app.latitude},spatialReference:{wkid:4326}}}],spatialReference:{wkid:4326}}"
          polygon_params = {
              'Input_Location' => input_location,
              'Drive_Times' => @user_app.searchDist,
              'f' => 'pjson',
          }
          res = Net::HTTP.post_form(uri, polygon_params)
          res = JSON.parse(res.body)
          if res['results'].present?
            polygon = res['results'][0]['value']['features'][0]['geometry']['rings'][0]
            render json: { polygon: polygon }
            return
          end
        end
      end
      #get directions from two points
      #"https://maps.googleapis.com/maps/api/directions/json?origin=49.515828,3.224381&destination=50.590798,30.825941"
    end
    render json: {status: "error", data: "Error"}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_app_params
      params.permit(:mobileNum, :firstName, :lastName, :latitude, :longitude, :email, :altitude, :address, :city, :state,
                    :zipcode, :country, :value, :bedrooms, :bathsFull, :squareFootageStructure, :lotSquareFootage, :maxBudget,
                    :minBeds, :minBaths, :startZip, :searchType, :searchDist, :metricUS, :propTypes, :mode)
    end

    def user_like_dislike_params
      params.permit(:userID, :mobileNum, :propertyID, :likeDislike, :tooFar, :tooClose, :badArea, :tooSmall, :houseTooBig, :lotTooBig,
                    :lotTooSmall, :ugly)
    end

end
