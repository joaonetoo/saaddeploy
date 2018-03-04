class PrincipalsController < ApplicationController
  before_action :set_principal, only: [:show, :edit, :update, :destroy]

  # GET /principals
  # GET /principals.json
  def index
    @principals = Principal.all
  end

  # GET /principals/1
  # GET /principals/1.json
  def show
  end

  # GET /principals/new
  def new
    @principal = Principal.new
    @institution_id = Institution.all.first.id
    @course_id = Course.all.first.id
  end

  # GET /principals/1/edit
  def edit
  end

  # POST /principals
  # POST /principals.json
  def create
    @principal = Principal.new(principal_params)
    @principal.type = 'Principal'
    respond_to do |format|
      if @principal.save
        format.html { redirect_to @principal, notice: 'Um novo diretor foi cadastrado!' }
        format.json { render :show, status: :created, location: @principal }
      else
        format.html { render :new }
        format.json { render json: @principal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /principals/1
  # PATCH/PUT /principals/1.json
  def update
    respond_to do |format|
      if @principal.update(principal_params)
        format.html { redirect_to @principal, notice: 'Principal was successfully updated.' }
        format.json { render :show, status: :ok, location: @principal }
      else
        format.html { render :edit }
        format.json { render json: @principal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /principals/1
  # DELETE /principals/1.json
  def destroy
    @principal.destroy
    respond_to do |format|
      format.html { redirect_to principals_url, notice: 'Um diretor foi excluido!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_principal
      @principal = Principal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def principal_params
      params.require(:principal).permit(:nome, :cpf, :telefone, :endereco, :lattes, :biografia, :matricula, :email, :institution_id, :course_id,:password, :password_confirmation, :avatar)
    end
end
