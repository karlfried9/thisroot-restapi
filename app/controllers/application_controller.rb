class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  respond_to :json

  protected
  def current_user
    if doorkeeper_token.resource_owner_id.present?
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end

  private
    def authenticate_user!
      #if doorkeeper_token and doorkeeper_token.resource_owner_id.present?
      head :not_authorized unless doorkeeper_token.resource_owner_id
      #end
    end

    def authenticate_token!
      #if doorkeeper_token and doorkeeper_token.resource_owner_id.present?
      token = ApiKey.find_by({:key => params[:api_key], :active => 1})
      head :not_authorized if token.nil?
      #end
    end
end
