class MainThemesController < ApplicationController
  before_action :set_main_theme, only: [:show, :edit, :update, :destroy]

  # GET /main_themes
  # GET /main_themes.json
  def index
    @main_themes = MainTheme.all
  end

  # GET /main_themes/1
  # GET /main_themes/1.json
  def show
  end

  # GET /main_themes/new
  def new
    @main_theme = MainTheme.new
  end

  # GET /main_themes/1/edit
  def edit
  end

  # POST /main_themes
  # POST /main_themes.json
  def create
    @main_theme = MainTheme.new(main_theme_params)

    respond_to do |format|
      if @main_theme.save
        format.html { redirect_to main_themes_path, notice: 'Tema Principal Cadastrado Com Sucesso.' }
        format.json { render :show, status: :created, location: @main_theme }
      else
        format.html { render :new }
        format.json { render json: @main_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /main_themes/1
  # PATCH/PUT /main_themes/1.json
  def update
    respond_to do |format|
      if @main_theme.update(main_theme_params)
        format.html { redirect_to main_themes_path, notice: 'Tema Principal Atualizado Com Sucesso.' }
        format.json { render :show, status: :ok, location: @main_theme }
      else
        format.html { render :edit }
        format.json { render json: @main_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_themes/1
  # DELETE /main_themes/1.json
  def destroy
    @main_theme.destroy
    respond_to do |format|
      format.html { redirect_to main_themes_url, notice: 'Main theme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_theme
      @main_theme = MainTheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_theme_params
      params.require(:main_theme).permit(:descricao)
    end
end
