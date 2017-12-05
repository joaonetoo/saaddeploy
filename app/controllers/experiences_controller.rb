class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:edit, :update, :destroy]



  def edit
  end

  # POST /languages
  def create
    @experience = Experience.new(experience_params)

    respond_to do |format|
      if @experience.save
        format.html { redirect_to experiences_path  , notice: 'Área do conhecimento cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @experience }
      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiences/1
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to experiences_path  , notice: 'Área do conhecimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_experience
      @experience = Experience.find(params[:id])
    end
    def experience_params
      params.require(:experience).permit(:institution,:office,:date_start,:date_end,:description,:curriculum_id)
    end
end

