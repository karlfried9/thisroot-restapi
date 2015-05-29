class MainController < ApplicationController
  def index
    @user = User.find_by(email: 'ana@cerveo.com')
    #@users = User.all
    #@user_app = Usersapp.first
    #render json: @user_app
  end
end
