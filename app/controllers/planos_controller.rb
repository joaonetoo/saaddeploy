class PlanosController < ApplicationController
  before_action :set_plano, only: [:show, :edit, :update, :destroy]

  # GET /planos
  # GET /planos.json
  def check_privilege(plano)
     unless current_user.id == plano.user_id
      redirect_to welcome_index_path
      return
    end
  end

  def index
    @planos = Plano.all
  end

  # GET /planos/1
  # GET /planos/1.json
  def show
    check_privilege(@plano)
  end

  # GET /planos/new
  def new
    @plano = Plano.new
  end

  # GET /planos/1/edit
  def edit
    check_privilege(@plano)
    @notes = Note.where(recipient: @plano.user).each.to_a
  end

  # POST /planos
  # POST /planos.json
  def create
    @plano = Plano.new(plano_params)
    @plano.user_id = current_user.id

    respond_to do |format|
      if @plano.save
        format.html { redirect_to welcome_index_path, notice: 'Plano Salvo.' }
        format.json { render :show, status: :created, location: @plano }
      else
        format.html { render :new }
        format.json { render json: @plano.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planos/1
  # PATCH/PUT /planos/1.json
  def update
    respond_to do |format|
      if @plano.update(plano_params)
        format.html { redirect_to welcome_index_path, notice: 'Plano Atualizado.' }
        format.json { render :show, status: :ok, location: @plano }
      else
        format.html { render :edit }
        format.json { render json: @plano.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planos/1
  # DELETE /planos/1.json
  def destroy
    check_privilege(@plano)
    @plano.destroy
    respond_to do |format|
      format.html { redirect_to planos_url, notice: 'Plano was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plano
      @plano = Plano.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plano_params
      params.require(:plano).permit(:publico, :ameacas, :respostas_ameaca, :oportunidades, :respostas_oportunidades, :fraquezas, :respostas_fraquezas, :forcas, :respostas_forcas, :missao, :objetivos_proximo_ano, :objetivos_cinco_anos, :objetivos_dez_anos, :objetivos, :estrategias, :plano_objetivo, :plano_estrategia, :plano_prazo, :plano_fator_critico, :plano_recursos)
    end
end
