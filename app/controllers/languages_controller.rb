class LanguagesController < ApplicationController
  before_action :set_language, only: [:edit, :update, :destroy]

def new
    @language = Language.new
end

def index
    @language = Language.all
end
  def edit
  end

  # POST /languages
  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to student_area_edit_curriculo_path  , notice: 'Idioma cadastrado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /languages/1
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to student_area_edit_curriculo_path  , notice: 'Área do conhecimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @language }
      else
        format.html { render :edit }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  def destroy
    @language.destroy
    respond_to do |format|
      format.html { redirect_to languages_url, notice: 'language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_language
      @language = Language.find(params[:id])
    end
    def language_params
      params.require(:language).permit(:idioma,:read,:speak,:write,:understand,:curriculum_id)
    end
end