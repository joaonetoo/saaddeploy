class LanguagesController < ApplicationController
  before_action :set_language, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def edit
  end

  # POST /languages
  def create
    @language = Language.new(language_params)
    @languages = Language.where(curriculum_id: @language.curriculum_id)
    respond_to do |format|
      if @language.save
        format.js
      end
    end
  end

  # PATCH/PUT /languages/1
  def update
    @language.read = params[:read]
    @language.speak = params[:speak]
    @language.write = params[:write]
    @language.understand = params[:understand]
    @language.idioma = params[:idioma]
    respond_to do |format|
      if @language.save
        format.js
      end
    end  end

  # DELETE /languages/1
  def destroy
    @language.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_language
      @language = Language.find(params[:id])
      @languages = Language.where(curriculum_id: @language.curriculum_id)
    end
    def language_params
      params.require(:language).permit(:idioma,:read,:speak,:write,:understand,:curriculum_id)
    end
end