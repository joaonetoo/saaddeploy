class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:create_message,:create_networks]
  skip_before_action :authenticate_user!, only:[:all_curriculums,:show]
  layout "curriculo", only: [:show]

  def create_message
    @curriculum.update(curriculums_params)
    respond_to do |format|
      format.html { redirect_to student_area_edit_curriculo_path }
    end
  end
  def show
    @usuario = User.find(params[:student])
    curriculums = Curriculum.all
    curriculums.each do |curriculum|
      if curriculum.user_id == @usuario.id
        @curriculum = curriculum
      end
    end
    @purposes = Purpose.where(curriculum_id: @curriculum.id)
    @skills = Skill.where(curriculum_id: @curriculum.id)
    @experiences = Experience.where(curriculum_id: @curriculum.id)
    @formations = Formation.where(curriculum_id: @curriculum.id)
    @languages = Language.where(curriculum_id: @curriculum.id)
    @qualifications = Qualification.where(curriculum_id: @curriculum.id)
    @temResultados = false
    if @usuario.learning_results != nil && @usuario.learning_results.length > 0 && @usuario.results != nil && @usuario.results.length > 0
        @temResultados = true
    end
    if @temResultados
      if @usuario.learning_results != nil && @usuario.learning_results.length > 0
        @learning_result = @usuario.learning_results.last
        @mediaDi = ((@learning_result.ec + @learning_result.or) / 2)
        @mediaAc = ((@learning_result.ec + @learning_result.ea) / 2)
        @mediaAs = ((@learning_result.or + @learning_result.ca) / 2)
        @mediaCo = ((@learning_result.ea + @learning_result.ca) / 2)
        @predominantes = {"co" => @mediaCo, "ac" => @mediaAc, "as" => @mediaAs, "di" => @mediaDi }.sort_by{ |k, v| v }.reverse.to_h
        @predominante1 = LearningStyle.where(sigla: @predominantes.keys[0]).first
        @predominante2 = LearningStyle.where(sigla: @predominantes.keys[1]).first
      end
      if @usuario.results != nil && @usuario.results.length > 0
        @result = @usuario.results.last
        hash = {"tf" => @result.tf, "gm" => @result.gm, "au" => @result.au, "se" => @result.se, "ec" => @result.ec, "sv" => @result.sv, "ch" => @result.ch, "ls" => @result.ls}
        @maiores = hash.max_by(2){|k,v| v}
        num1 = @maiores[0][1]
        num2 = @maiores[1][1]
        @maior1 = @maiores[0][0]
        @maior2 = @maiores[1][0]
        if num1 > num2
              @ancora1 = Anchorinfo.where(tipo: @maior1).first
              @ancora2 = Anchorinfo.where(tipo: @maior2).first
        else
              @ancora1 = Anchorinfo.where(tipo: @maior2).first
              @ancora2 = Anchorinfo.where(tipo: @maior1).first
        end
      end
    end
  end

  def all_curriculums
    @curriculums = Curriculum.all
    @students =[]
    @curriculums.each do |curriculum|
     if curriculum.user_id.nil?
      student = User.find(curriculum.user_id)
      @students << student
     end
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
