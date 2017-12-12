class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def edit
    respond_to do |format|
      format.js 
    end
  end

  # POST /languages
  def create
    @experience = Experience.new(experience_params)
    @experiences = Experience.where(curriculum_id: @experience.curriculum_id)
    respond_to do |format|
      if @experience.save
        format.js 
      end
    end

  end

  # PATCH/PUT /experiences/1
  def update
    @experience.office = params[:office]
    @experience.institution = params[:institution]
    @experience.date_start = params[:date_start]
    @experience.date_end = params[:date_end]
    @experience.description = params[:description]
    respond_to do |format|
        if @experience.save
          format.js
        end
    end
  end


  # DELETE /experiences/1
  def destroy
    @experience.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_experience
      @experience = Experience.find(params[:id])
      @experiences = Experience.where(curriculum_id: @experience.curriculum_id)

    end
    def experience_params
      params.require(:experience).permit(:institution,:office,:date_start,:date_end,:description,:curriculum_id)
    end
end

