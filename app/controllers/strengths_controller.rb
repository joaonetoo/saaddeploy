class StrengthsController < ApplicationController
  before_action :set_strength, only: [:show, :edit, :update, :destroy]

  # GET /strengths
  # GET /strengths.json
  def index
    @strengths = Strength.all
  end

  # GET /strengths/1
  # GET /strengths/1.json
  def show
  end

  # GET /strengths/new
  def new
    @strength = Strength.new
  end

  # GET /strengths/1/edit
  def edit
  end

  # POST /strengths
  # POST /strengths.json
  def create
    @strength = Strength.new(strength_params)
    @plano = current_user.plano
    @strengths = @plano.strengths

    respond_to do |format|
      if @strength.save
        format.html { redirect_to @strength, notice: 'Strength was successfully created.' }
        format.json { render :show, status: :created, location: @strength }
        format.js
      else
        format.html { render :new }
        format.json { render json: @strength.errors, status: :unprocessable_entity }
        format.js   { render json: @strength.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /strengths/1
  # PATCH/PUT /strengths/1.json
  def update
    respond_to do |format|
      if @strength.update(strength_params)
        format.html { redirect_to @strength, notice: 'Strength was successfully updated.' }
        format.json { render :show, status: :ok, location: @strength }
      else
        format.html { render :edit }
        format.json { render json: @strength.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /strengths/1
  # DELETE /strengths/1.json
  def destroy
    @strength.destroy
    @plano = current_user.plano
    @strengths = @plano.strengths
    respond_to do |format|
      format.html { redirect_to strengths_url, notice: 'Strength was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_strength
      @strength = Strength.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def strength_params
      params.require(:strength).permit(:text, :plano_id)
    end
end
