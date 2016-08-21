class RespostaController < ApplicationController
  before_action :set_respostum, only: [:show, :edit, :update, :destroy]

  # GET /resposta
  # GET /resposta.json
  def index
    @resposta = Respostum.all
  end

  # GET /resposta/1
  # GET /resposta/1.json
  def show
  end

  # GET /resposta/new
  def new
    @respostum = Respostum.new
  end

  # GET /resposta/1/edit
  def edit
  end

  # POST /resposta
  # POST /resposta.json
  def create
    @respostum = Respostum.new(respostum_params)

    respond_to do |format|
      if @respostum.save
        format.html { redirect_to @respostum, notice: 'Respostum was successfully created.' }
        format.json { render :show, status: :created, location: @respostum }
      else
        format.html { render :new }
        format.json { render json: @respostum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resposta/1
  # PATCH/PUT /resposta/1.json
  def update
    respond_to do |format|
      if @respostum.update(respostum_params)
        format.html { redirect_to @respostum, notice: 'Respostum was successfully updated.' }
        format.json { render :show, status: :ok, location: @respostum }
      else
        format.html { render :edit }
        format.json { render json: @respostum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resposta/1
  # DELETE /resposta/1.json
  def destroy
    @respostum.destroy
    respond_to do |format|
      format.html { redirect_to resposta_url, notice: 'Respostum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_respostum
      @respostum = Respostum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def respostum_params
      params.require(:respostum).permit(:observacao, :atividade_extra_id)
    end
end
