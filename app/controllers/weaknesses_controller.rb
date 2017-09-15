class WeaknessesController < ApplicationController
  before_action :set_weakness, only: [:show, :edit, :update, :destroy]

  # GET /weaknesses
  # GET /weaknesses.json
  def index
    @weaknesses = Weakness.all
  end

  # GET /weaknesses/1
  # GET /weaknesses/1.json
  def show
  end

  # GET /weaknesses/new
  def new
    @weakness = Weakness.new
  end

  # GET /weaknesses/1/edit
  def edit
    @plano = current_user.plano
    respond_to do |format|
      format.js
    end

  end

  # POST /weaknesses
  # POST /weaknesses.json
  def create
    @weakness = Weakness.new(weakness_params)
    @plano = current_user.plano
    @weaknesses = @plano.weaknesses
    respond_to do |format|
      if @weakness.save
        format.html { redirect_to @weakness, notice: 'Fraqueza criada com sucesso.' }
        format.json { render :show, status: :created, location: @weakness }
        format.js
      else
        format.html { render :new }
        format.json { render json: @weakness.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weaknesses/1
  # PATCH/PUT /weaknesses/1.json
  def update
    respond_to do |format|
      hash2 = { text: params[:text], plano_id: params[:plano_id]}
      if @weakness.update(hash2)
        format.html { redirect_to student_area_my_plan_path, notice: 'Fraqueza atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @weakness }
      else
        format.html { render :edit }
        format.json { render json: @weakness.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weaknesses/1
  # DELETE /weaknesses/1.json
  def destroy
    @weakness.destroy
    @plano = current_user.plano
    @weaknesses = @plano.weaknesses
    respond_to do |format|
      format.html { redirect_to weaknesses_url, notice: 'Weakness was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weakness
      @weakness = Weakness.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weakness_params
      params.require(:weakness).permit(:text, :plano_id)
    end
end
