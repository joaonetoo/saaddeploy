class PrincipalsAreaController < ApplicationController
  def index
    @videos = current_user.sent_videos
    @pendings_students = User.where(type: 'Student', approved: false, institution_id: current_user.institution.id).find_each
    @pendings_teachers = User.where(type: 'Teacher', approved: false, institution_id: current_user.institution.id).find_each
    @pendings_coordinators = User.where(type: 'Coordinator', approved: false, institution_id: current_user.institution.id).find_each
  end

  def aprove
    @pending = User.where(id: params[:pending]).first
    @pending.approved = true
    @pending.save
    @learning_quizzes = LearningQuiz.all.sort_by &:created_at
    @learning_quiz = @learning_quizzes.last
    @learning_quiz.users << @pending
    @quizzes = Quiz.all.sort_by &:created_at
    @quiz = @quizzes.last
    @quiz.users << @pending
    flash[:notice] = 'usuario aprovado'
    redirect_to welcome_index_path
  end

  def setup_principal_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @subjects = []
    @classrooms = []
    @students = []
    @anos = []
    @semestres = []
    @institution = Institution.find(current_user.institution_id)
    @campus = current_user.campus
    @campus.each do |campu|
      pre = Center.where(campu: campu).load
      pre.each do |p|
        if not p.nil?
          @centers << p
        end
      end
    end
    @centers.each do |center|
      pre = Course.where(center: center).load
      pre.each do |p|
        if not p.nil?
          @courses << p
        end
      end
    end
    @courses.each do |course|
      pre = Subject.where(course: course).load
      pre.each do |p|
        if not p.nil?
          @subjects << p
        end
      end
    end
    @subjects.each do |subject|
      pre = Classroom.where(subject: subject).load
       pre.each do |p|
        if not p.nil?
          @classrooms << p
        end
      end
    end
    @classrooms.each do |classroom|
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}
  end

  def create_video
  end

  def list
    if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id], type: 'Student').all
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
      @centers = []
      @campus.each do |campus|
          @centers << Center.where(campu_id: campus.id)
      end
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.ids)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids, type: 'Student')
      end
      @users = @users.first.to_a
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @centers = @campus.centers.all
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids, type: 'Student')
      end
    end

    if params[:center_id] == 'todos' && params[:campu_id] != 'todos'
      @centers = Center.where(campu_id: params[:campu_id]).find_each
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids,  type: 'Student')
      end
      @users = @users.first.to_a


    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @center = Center.where(campu_id: params[:campu_id]).first
      @selecao = @center.name
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end
    end

    if params[:course_id] != 'todos' && params[:center_id] != nil && params[:center_id] != 'todos'
      if current_user.type == 'Teacher'
        setup_teacher_search
        @selecao = "todos os meus alunos"
      else
        @users = User.where(course_id: params[:course_id], type: 'Student').find_each
        @users = @users.to_a
        @course = Course.where(id: params[:course_id]).first
        @selecao = @course.nome
      end
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @subject = Subject.find(params[:subject_id])
      if current_user.type == 'Teacher'
        @classrooms = []
        @subject.classrooms.each do |classroom|
          classroom.users.each do |user|
            if user.id == current_user.id
              @classrooms << classroom
            end
          end
        end
      elsif current_user.type == 'Coordinator' || 'Principal'
        @classrooms = @subject.classrooms
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = @subject.nome
    end
#ano
    if params[:ano] != 'todos' && params[:ano] != nil
      @ano = params[:ano]
      if current_user.type == 'Teacher'
        @classrooms = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject && classroom.ano == @ano
            @classrooms << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || 'Principal'
        @subject.classrooms.each do |classroom|
          if classroom.ano == @ano
            @classrooms << classroom
          end
        end
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = "#{@subject.nome}, #{@ano}"
    end
#
#semestre
    if params[:semestre] != 'todos' && params[:semestre] != nil
      @semestre = params[:semestre]
      if current_user.type == 'Teacher'
        @classrooms = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject && classroom.ano == @ano && classroom.semestre == @semestre
            @classrooms << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || 'Principal'
        @subject.classrooms.each do |classroom|
          if classroom.semestre == @semestre && classroom.ano == @ano
            @classrooms << classroom
          end
        end
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = "#{@semestre} semestre, #{@ano}, #{@subject.nome}"
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @users = []
      @classroom.users.each do |user|
        if(user.type == 'Student')
          @users << user
        end
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end

    if @users != nil
      @users = @users.uniq
      @results = []
      @users.each do |user|
          user.results.each do |result|
            @results << result
          end
      end

      @datas = @results.map(&:data_final).uniq
    else
      redirect_to no_users_error_results_path, notice: 'Não há usuarios disponiveis para exibir'
    end
  end

  def my_events
    @events = Event.where(:user_id => current_user.id)
  end

  def search_anchors
  end

  def search_plans
    setup_principal_search
  end

  def send_video
  end

  def show_plan
  end

  def videos_index
  end
end
