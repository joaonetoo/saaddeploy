class AnchorinfosController < ApplicationController
  before_action :set_anchorinfo, only: [:show, :edit, :update, :destroy]

  # GET /anchorinfos
  # GET /anchorinfos.json
  def index
    @anchorinfos = Anchorinfo.all
  end

  # GET /anchorinfos/1
  # GET /anchorinfos/1.json
  def show
  end

  # GET /anchorinfos/new
  def new
    @anchorinfo = Anchorinfo.new
  end

  # GET /anchorinfos/1/edit
  def edit
  end

  # POST /anchorinfos
  # POST /anchorinfos.json
  def create
    @anchorinfo = Anchorinfo.new(anchorinfo_params)

    respond_to do |format|
      if @anchorinfo.save
        format.html { redirect_to @anchorinfo, notice: 'Anchorinfo was successfully created.' }
        format.json { render :show, status: :created, location: @anchorinfo }
      else
        format.html { render :new }
        format.json { render json: @anchorinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anchorinfos/1
  # PATCH/PUT /anchorinfos/1.json
  def update
    respond_to do |format|
      if @anchorinfo.update(anchorinfo_params)
        format.html { redirect_to @anchorinfo, notice: 'Anchorinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @anchorinfo }
      else
        format.html { render :edit }
        format.json { render json: @anchorinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anchorinfos/1
  # DELETE /anchorinfos/1.json
  def destroy
    @anchorinfo.destroy
    respond_to do |format|
      format.html { redirect_to anchorinfos_url, notice: 'Anchorinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anchorinfo
      @anchorinfo = Anchorinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anchorinfo_params
      params.require(:anchorinfo).permit(:nome, :descricao, :perfil, :perspectiva, :tipo)
    end
end
