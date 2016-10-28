class CoordinatorsAreaController < ApplicationController
  require "prawn/measurement_extensions"

  def setup_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @institution = Institution.find(current_user.institution_id)
    @course = Course.find(current_user.course_id)
    @center = @course.center
    @campu = @center.campu

    @subjects = current_user.course.subjects
    @classrooms = []
    @students = []
    @subjects.each do |subject|
        subject.classrooms.each do |classroom|
          classroom.users.each do |user|
            if user.type == 'Student'
            @students << user
            end
          end
          @classrooms << classroom
      end
    end
    @classrooms.uniq!
    @students = @students.uniq { |s| s.nome}
    @institutions << @institution
    @courses << @course
    @centers << @center
    @campus << @campu

  end

  def index
    @pendings_students = User.where(type: 'Student', approved: false, course_id: current_user.course.id).find_each
    @pendings_teachers = User.where(type: 'Teacher', approved: false, course_id: current_user.course.id).find_each
  end

  def aprove
    @pending = User.where(id: params[:pending]).first
    @pending.approved = true
    @pending.save
    flash[:notice] = 'usuario aprovado'
    redirect_to welcome_index_path
  end

  def videos_index
    @videos = current_user.sent_videos
  end

  def search_anchors
    setup_search
  end

  def search_learning
    setup_search
  end

  def search_learning_analytics
    setup_search
  end

  def search_analytics
    setup_search
  end

  def my_events
      @events = Event.where(:user_id => current_user.id).where("fim > ?", Date.today)
  end

  def finished_events
    @events = Event.where(:user_id => current_user.id).where("fim <= ?", Date.today)
  end

  def show_finished_event
    @event = Event.find(params[:event])
    @projects = @event.projects
    @activities = @event.activities
    @matriculations = @event.matriculations
  end


  def send_video
    setup_search
  end

  def create_video
    @video = Video.new
    @video.titulo = params[:titulo]
    @video.description = params[:description]
    @video.url = @video.youtubeRegExp(params[:url])
    @video.sender_id = current_user.id
    current_user.sent_videos << @video
    @video.save

     if params[:subject_id] == 'todos'
      setup_search
      @users = @students
      @selecao = "todas as disciplinas"
    end

     if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @subject = Subject.where(id: params[:subject_id]).first
      @selecao = @subject.nome
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


    @users = @users.uniq { |s| s.nome}
    @users.each do |user|
        if user.type == 'Student'
          @video.recipients << user
        end
    end

  end

  def search_plans
    setup_search
  end

  def list
    @students = []
    if params[:classroom_id] == 'todos'
      @selecao = 'todos'
      @subjects = current_user.course.subjects
      @classrooms = []
      @subjects.each do |subject|
        subject.classrooms.each do |classroom|
          @classrooms << classroom
        end
      end
      @classrooms.uniq!
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.type == 'Student'
            @students << user
          end
        end
      end
    else
    @classroom = Classroom.find(params[:classroom_id])
      @classroom.users.each do |user|
        if user.type == 'Student'
            @students << user
        end
      end
    end
    @students = @students.uniq { |s| s.nome}
  end

  def show_plan
    @plano = Plano.find(params[:plano])
    #@note = Note.new
    #@note.sender_id = current_user
    #@note.recipient_id = @plano.user.id
  end

  def pdf_plan
    @result = LearningResult.find(params[:result])
    student = User.find(@result.user.id)
    respond_to do |format|
      format.html
      format.pdf {
        pdf = Prawn::Document.new
          #pdf.image "#{student.avatar.path(:thumb)}", :scale => 0.75
          pdf.font("Helvetica", :style => :bold)
          pdf.text "Nome do aluno: #{@plano.user.nome.capitalize}", :align => :center, :size => 14
          pdf.text "editado em: #{@plano.updated_at.strftime("%d/%m/%Y")}", :align => :center, :size => 10
          pdf.move_down 40

          pdf.text "1.0 Ameaças", :align => :left, :size => 12

          pdf.move_down 5

          pdf.font("Helvetica")
          pdf.text "#{@plano.ameacas}", :align => :left, :size => 10
          pdf.font("Helvetica", :style => :bold)

          pdf.move_down 20

          pdf.text "1.1 Resposta Ameaças", :align => :left, :size => 10
          pdf.move_down 5

          pdf.font("Helvetica")
          pdf.text "#{@plano.respostas_ameaca}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "2.0 oportunidades", :align => :left, :size => 12
          pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.oportunidades}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "2.1 Resposta Oportunidades", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.respostas_oportunidades}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "3.0 fraquezas", :align => :left, :size => 12
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.fraquezas}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "3.1 Resposta Fraquezas", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.respostas_fraquezas}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "4.0 Forças", :align => :left, :size => 12
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.forcas}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "4.1 Resposta Forcas", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.respostas_forcas}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "5.0 Minha missão", :align => :left, :size => 12
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.missao}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "6.0 Meus objetivos ", :align => :left, :size => 12

          pdf.move_down 10

          pdf.font("Helvetica", :style => :bold)
          pdf.text "6.1 Objetivos para o proximo ano", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.objetivos_proximo_ano}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "6.2 Objetivos para daqui a cinco anos", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.objetivos_cinco_anos}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "6.3 Objetivos para daqui a dez anos", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.objetivos_dez_anos}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "7.0 Minhas Estratégias ", :align => :left, :size => 12

          pdf.move_down 10

          pdf.font("Helvetica", :style => :bold)
          pdf.text "7.1 Objetivos", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.objetivos}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "7.2 Estratégias", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.estrategias}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "8.0 Plano de ação ", :align => :left, :size => 12

          pdf.move_down 10

          pdf.font("Helvetica", :style => :bold)
          pdf.text "8.1 Objetivos", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.plano_objetivo}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "8.2 Estratégia", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.plano_estrategia}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "8.3 Prazo", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.plano_prazo}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "8.4 Fator Crítico de sucesso", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.plano_fator_critico}", :align => :left, :size => 10

          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "8.5 Recursos", :align => :left, :size => 10
           pdf.move_down 5
          pdf.font("Helvetica")
          pdf.text "#{@plano.plano_recursos}", :align => :left, :size => 10




        send_data pdf.render, filename: 'plan.pdf', type: 'application/pdf', disposition: "inline"
      }
    end
  end

  def add_note
    respond_to do |format|
        format.js {}
    end
  end
end
