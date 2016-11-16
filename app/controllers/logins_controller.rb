class LoginsController < ApplicationController
  rescue_from AuthError, :with => :invalid_key
  # GET /logins/new
  def new
  end

  # POST /logins
  def create
    service = MarvelService.new(login_params[:public_key], login_params[:private_key])
    service.import_characters
    session[:public_key]  = login_params[:public_key]
    session[:private_key] = login_params[:private_key]
  end

  def auth_error
  end
  
  private
  def login_params
    params.require(:login).permit(:public_key, :private_key)
  end

  def invalid_key
    redirect_to auth_error_logins_url
  end
  

end
