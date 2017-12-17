class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:create_message,:create_networks]

  def create_message
    @curriculum.update(curriculums_params)
    respond_to do |format|
      format.html { redirect_to student_area_edit_curriculo_path }
    end
  end

  def create_networks
    @curriculum.update(curriculums_params)
    respond_to do |format|
      format.html { redirect_to student_area_edit_curriculo_path }
    end
  end
  	private
	def curriculums_params
		params.require(:curriculum).permit(:message,:twitter,:facebook,:linkedin)
	end

  def set_curriculum
    @usuario = current_user
    curriculums = Curriculum.all
    curriculums.each do |curriculum|
      if curriculum.user_id == @usuario.id
        @curriculum = curriculum
      end
    end
  end

end
