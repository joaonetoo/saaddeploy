class QualificationsController < ApplicationController
  before_action :set_qualification, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def edit
    respond_to do |format|
      format.js 
    end
  end

  def create
    @qualification = Qualification.new(qualification_params)
    @qualifications = Qualification.where(curriculum_id: @qualification.curriculum_id)
    respond_to do |format|
      if @qualification.save
        format.js 
      end
    end
  end

  # PATCH/PUT /qualifications/1
  def update
    @qualification.description = params[:description]
    @qualification.save
    respond_to do |format|
        format.js
      end
  end

  # DELETE /qualifications/1
  # DELETE /qualifications/1.json
  def destroy
    @qualification.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_qualification
      @qualification = Qualification.find(params[:id])
      @qualifications = Qualification.where(curriculum_id: @qualification.curriculum_id)
    end

    def qualification_params
      params.require(:qualification).permit(:description,:curriculum_id)
    end

end
