class FormationsController < ApplicationController
  before_action :set_formation, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def edit
    respond_to do |format|
      format.js 
    end
  end

  # POST /languages
  def create
    @formation = Formation.new(formation_params)
    @formations = Formation.where(curriculum_id: @formation.curriculum_id)
    respond_to do |format|
      if @formation.save
        format.js 
      end
    end

  end

  # PATCH/PUT /formations/1
  def update
  end

  # DELETE /formations/1
  def destroy
    @formation.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_formation
      @formation = Formation.find(params[:id])
      @formations = Formation.where(curriculum_id: @formation.curriculum_id)
    end
    def formation_params
      params.require(:formation).permit(:nivel,:institution,:course,:date_start,:date_end,:curriculum_id)
    end
end
