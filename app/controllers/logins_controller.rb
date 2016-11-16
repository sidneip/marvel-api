class LoginsController < ApplicationController
  # GET /logins/new
  def new
  end

  # POST /logins
  def create
    service = MarvelService.new(login_params[:public_key], login_params[:private_key])
    service.import_characters
    session[:public_key]  = login_params[:public_key]
    session[:private_key] = login_params[:private_key]
    redirect_to characters_path
  end

  def auth_error
  end

  private
  def login_params
    params.require(:login).permit(:public_key, :private_key)
  end

end
