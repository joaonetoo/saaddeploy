class FormationsController < ApplicationController
  before_action :set_formation, only: [:edit, :update, :destroy]



  def edit
  end

  # POST /languages
  def create
    @formation = Formation.new(formation_params)

    respond_to do |format|
      if @formation.save
        format.html { redirect_to formations_path  , notice: 'Área do conhecimento cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @formation }
      else
        format.html { render :new }
        format.json { render json: @formation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formations/1
  def update
    respond_to do |format|
      if @formation.update(formation_params)
        format.html { redirect_to formations_path  , notice: 'Área do conhecimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @formation }
      else
        format.html { render :edit }
        format.json { render json: @formation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formations/1
  def destroy
    @formation.destroy
    respond_to do |format|
      format.html { redirect_to formations_url, notice: 'formation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_formation
      @formation = Formation.find(params[:id])
    end
    def formation_params
      params.require(:formation).permit(:institution,:course,:date_start,:date_end,:curriculum_id)
    end
end
