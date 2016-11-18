class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from AuthError, :with => :invalid_key
  private
  
  def invalid_key
    redirect_to auth_error_logins_url
  end
end
