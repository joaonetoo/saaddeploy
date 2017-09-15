class ThreatsController < ApplicationController
  before_action :set_threat, only: [:show, :edit, :update, :destroy]

  # GET /threats
  # GET /threats.json
  def index
    @threats = Threat.all
  end

  # GET /threats/1
  # GET /threats/1.json
  def show
  end

  # GET /threats/new
  def new
    @threat = Threat.new
  end

  # GET /threats/1/edit
  def edit
    @plano = current_user.plano
    respond_to do |format|
      format.js
    end
  end

  # POST /threats
  # POST /threats.json
  def create
    @threat = Threat.new(threat_params)
    @plano = current_user.plano
    @threats = @plano.threats

    respond_to do |format|
      if @threat.save
        format.html { redirect_to @threat, notice: 'A Ameaça foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @threat }
        format.js
      else
        format.html { render :new }
        format.json { render json: @threat.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /threats/1
  # PATCH/PUT /threats/1.json
  def update
    respond_to do |format|
      hash2 = { text: params[:text], plano_id: params[:plano_id]}
      if @threat.update(hash2)
        format.html { redirect_to student_area_my_plan_path, notice: 'A Ameaça foi atualizada.' }
        format.json { render :show, status: :ok, location: @threat }
      else
        format.html { render :edit }
        format.json { render json: @threat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /threats/1
  # DELETE /threats/1.json
  def destroy
    @threat.destroy
    @plano = current_user.plano
    @threats = @plano.threats
    respond_to do |format|
      format.html { redirect_to threats_url, notice: 'Threat was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_threat
      @threat = Threat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def threat_params
      params.require(:threat).permit(:text, :plano_id)
    end
end
