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
      @user_app.registrationDate = DateTime.now.to_date
      @user_app.lastLogin = DateTime.now.to_date
      @user_app.loginCount = 0
      if @user_app.save
        render json: @user_app
      else
        render json: {status: "failure"}
      end
    else
      if @user_app.update(user_app_params)
        render json: @user_app
      else
        render json: {status: "failure"}
      end
    end
  end

  def search_caret_properties
    mobile_number = params[:mobileNum]
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

    # additional search fields
    @caret_properties = @caret_properties.where('ListPrice <= ?', @user_app.maxBudget).select("*," + @user_app.maxBudget.to_s + " - ListPrice as sub_price")
    if @user_app.metricUS == 1
      dist_param = 1
    else
      dist_param = 1.609344
    end
    if @user_app.latitude != 0 and @user_app.longitude != 0 and @user_app.searchType != '' and @user_app.searchDist != 0 and @user_app.startZip == ''
      @caret_properties = @caret_properties.select("(((acos(sin((" + @user_app.latitude + "*pi()/180)) *
                                                                 sin((`Latitude`*pi()/180))+cos(("+ @user_app.latitude + "*pi()/180)) *
                                                                 cos((`Latitude`*pi()/180)) * cos((("+ @user_app.longitude + "- `Longitude`)*
                                                                                                      pi()/180))))*180/pi())*60*1.1515
                                                    ) as distance" ).where('distance < ?', @user_app.searchDist*dist_param)
    end

    if @user_app.startZip != '' and @user_app.searchType != '' and @user_app.searchDist != 0
      uri = URI('http://maps.googleapis.com/maps/api/geocode/json?address=' + @user_app.startZip)
      req = Net::HTTP.get(uri)
      req = JSON.parse(req)
      if req['results'].present?
        lat = req['results'][0]['geometry']['location']['lat']
        lang = req['results'][0]['geometry']['location']['lat']
        @user_app.latitude = lat
        @user_app.longitude = lang
        @user_app.save
        @caret_properties = @caret_properties.select("(((acos(sin((" + @user_app.latitude.to_s + "*pi()/180)) *
                                                                   sin((`Latitude`*pi()/180))+cos(("+ lat.to_s + "*pi()/180)) *
                                                                   cos((`Latitude`*pi()/180)) * cos((("+ lang.to_s + "- `Longitude`)*
                                                                                                        pi()/180))))*180/pi())*60*1.1515
                                                      ) as distance" ).having('distance < ?', (@user_app.searchDist*dist_param).round(2).to_s)
      end
      #get directions from two points
      "https://maps.googleapis.com/maps/api/directions/json?origin=49.515828,3.224381&destination=50.590798,30.825941"
    end

    if @user_app.startZip != 0 and @user_app.searchType == '' and @user_app.searchDist == 0
      @caret_properties = @caret_properties.where('ZipCode = ?', @user_app.startZip)
    end

    if @user_app.bedrooms != 0 and @user_app.minBeds == 0
      @caret_properties = @caret_properties.where('Bedrooms >= ?', @user_app.bedrooms)
    end

    if @user_app.bathsFull != 0 and @user_app.minBaths == 0
      @caret_properties = @caret_properties.where('BathsFull >= ?', @user_app.bathsFull)
    end

    if @user_app.squareFootageStructure != 0
      @caret_properties = @caret_properties.where('SquareFootageStructure >= ?', @user_app.squareFootageStructure).select("SquareFootageStructure / " + @user_app.squareFootageStructure.to_s + " as div_squareFootageStructure")
    end

    if @user_app.lotSquareFootage != 0
      @caret_properties = @caret_properties.where('LotSquareFootage >= ?', @user_app.lotSquareFootage).select("LotSquareFootage / " + @user_app.lotSquareFootage.to_s + " as div_lotSquareFootage")
    end

    if @user_app.minBeds != 0
      @caret_properties = @caret_properties.where('Bedrooms >= ?', @user_app.minBeds).select("Bedrooms - " + @user_app.minBeds.to_s + " as sub_bed")
    end

    if @user_app.minBaths != 0
      @caret_properties = @caret_properties.where('BathsFull >= ?', @user_app.minBaths).select("BathsFull - " + @user_app.minBaths.to_s + " as sub_bath")
    end

    if @user_app.propTypes != ''
      prop_types = @user_app.propTypes.split(",")
      @caret_properties = @caret_properties.where('PropertySubType IN(?)', prop_types)
    end

    @caret_properties = @caret_properties.where("SaleYN = 'Y'")
    @caret_properties = @caret_properties.where("Status IN ('Active','Pending Sale','Backup Offer')")
    @caret_properties = @caret_properties.order("Propertyid")
    #@caret_properties = @caret_properties.paginate(:page => 2, :per_page => 2)
    # Since there are some issue for will_paginate when we use having caluse so we implement it manually.
    per_page = 10
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
      like = params[:likeDislike] == 0 ? TRUE : FALSE
      @user_like_dislikes = @user_like_dislikes.where(likeDislike: like)

      property_ids = params[:propertyID].split(",")
      if property_ids.count > 0
        @user_like_dislikes = @user_like_dislikes.where(propertyID: property_ids)
      end
      @user_like_dislikes.each do |like_property|
        like_property.destroy
      end
    end
    render json: {status: "success", data: "success"}
  end

  def user_liked_properties
    mobile_number = params[:mobileNum]
    @caret_properties = CaretProperty.where(:Propertyid => UserLikeDislike.where(mobileNum: mobile_number, likeDislike: TRUE).select(:propertyId))
    render json: @caret_properties
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_app_params
      params.permit(:mobileNum, :firstName, :lastName, :latitude, :longitude, :email, :altitude, :address, :city, :state,
                    :zipcode, :country, :value, :bedrooms, :bathsFull, :squareFootageStructure, :lotSquareFootage, :maxBudget,
                    :minBeds, :minBaths, :startZip, :searchType, :searchDist, :metricUS, :propTypes)
    end

    def user_like_dislike_params
      params.permit(:userID, :mobileNum, :propertyID, :likeDislike, :tooFar, :tooClose, :badArea, :tooSmall, :houseTooBig, :lotTooBig,
                    :ugly)
    end

end
