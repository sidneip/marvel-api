class Api::CharactersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /api/characters
  # GET /api/characters.json
  def index
    @characters = Character.all
    render json: @characters
  end

  # GET /api/characters/1
  # GET /api/characters/1.json
  def show
    render json: @character
  end

  # POST /api/characters
  # POST /api/characters.json
  def create
    @character = Character.new(character_params)
    if @character.save
      render json: @character, status: 201
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/characters/1
  # PATCH/PUT /api/characters/1.json
  def update
    if @character.update(character_params)
      render json: @character, status: 201, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/characters/1
  # DELETE /api/characters/1.json
  def destroy
    if @character.destroy
      head :no_content
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    def not_found
      render json: { error: "not_found".to_json }, status: 404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:name, :description)
    end
end
