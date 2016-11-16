class CharactersController < ApplicationController
  def index
    @characters = Character.all.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @character = Character.find params[:id]
  end
end
