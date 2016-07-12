class LearningStylesController < ApplicationController
  before_action :set_learning_style, only: [:show, :edit, :update, :destroy]

  # GET /learning_styles
  # GET /learning_styles.json
  def index
    @learning_styles = LearningStyle.all
  end

  # GET /learning_styles/1
  # GET /learning_styles/1.json
  def show
  end

  # GET /learning_styles/new
  def new
    @learning_style = LearningStyle.new
  end

  # GET /learning_styles/1/edit
  def edit
  end

  # POST /learning_styles
  # POST /learning_styles.json
  def create
    @learning_style = LearningStyle.new(learning_style_params)

    respond_to do |format|
      if @learning_style.save
        format.html { redirect_to @learning_style, notice: 'Learning style was successfully created.' }
        format.json { render :show, status: :created, location: @learning_style }
      else
        format.html { render :new }
        format.json { render json: @learning_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learning_styles/1
  # PATCH/PUT /learning_styles/1.json
  def update
    respond_to do |format|
      if @learning_style.update(learning_style_params)
        format.html { redirect_to @learning_style, notice: 'Learning style was successfully updated.' }
        format.json { render :show, status: :ok, location: @learning_style }
      else
        format.html { render :edit }
        format.json { render json: @learning_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_styles/1
  # DELETE /learning_styles/1.json
  def destroy
    @learning_style.destroy
    respond_to do |format|
      format.html { redirect_to learning_styles_url, notice: 'Learning style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_style
      @learning_style = LearningStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def learning_style_params
      params.require(:learning_style).permit(:nome, :descricao, :sigla)
    end
end
