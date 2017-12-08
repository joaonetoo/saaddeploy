class SkillsController < ApplicationController
  before_action :set_skill, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def edit
    respond_to do |format|
      format.js 
    end
  end

  # POST /languages
  def create
    @skill = Skill.new(skill_params)
    @skills = Skill.where(curriculum_id: @skill.curriculum_id)
    respond_to do |format|
      if @skill.save
        format.js 
      end
    end
  end

  # PATCH/PUT /skills/1
  def update
    @skill.description = params[:description]
    @skill.save
    respond_to do |format|
        format.js
      end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_skill
      @skill = Skill.find(params[:id])
      @skills = Skill.where(curriculum_id: @skill.curriculum_id)
    end
    def skill_params
      params.require(:skill).permit(:description,:curriculum_id)
    end
end

