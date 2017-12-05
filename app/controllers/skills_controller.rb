class SkillsController < ApplicationController
  before_action :set_skill, only: [:edit, :update, :destroy]

  def edit
  end

  # POST /languages
  def create
    @skill = Skill.new(skill_params)
    respond_to do |format|
      if @skill.save
        format.html { redirect_to skills_path  , notice: 'Área do conhecimento cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @skill }
      else
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills/1
  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to skills_path  , notice: 'Área do conhecimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @skill }
      else
        format.html { render :edit }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to skills_url, notice: 'skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_skill
      @skill = Skill.find(params[:id])
    end
    def skill_params
      params.require(:skill).permit(:description,:curriculum_id)
    end
end

