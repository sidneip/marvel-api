class CharactersController < ApplicationController
  def index
    @characters = Character.all.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @character = Character.find params[:id]
    character_service = MarvelService.new(session[:public_key], session[:private_key])
    @character_request = character_service.get_character(@character.code)
  end
end
