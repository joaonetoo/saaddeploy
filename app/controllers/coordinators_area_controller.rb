class CoordinatorsAreaController < ApplicationController
  require "prawn/measurement_extensions"

  def index
  end

  def videos_index
    @videos = current_user.sent_videos
  end

  def send_video
    @course = current_user.course
    @subjects = Subject.where(:course_id => @course.id)
    @subjects.each do |subject|
      @classrooms = Classroom.where(subject_id: subject.id).find_each
    end
    @students = []
    @classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.type == 'Student'
              @students << user
          end
        end
    end
  end

  def create_video
    @video = Video.new
    @video.description = params[:description]
    @video.url = @video.youtubeRegExp(params[:url])
    @video.sender_id = current_user.id
    current_user.sent_videos << @video
    @video.save

    if params[:classroom_id] == 'todos'
      @classrooms = current_user.classrooms
      @selecao = "Todas as turmas"
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
        end
      end

    elsif params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @users = []
      @classroom.users.each do |user|
        @users << user
      end
    end


    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end
    @users.each do |user|
        if user.type == 'Student'
          @video.recipients << user
        end
    end

  end

  def search_plans
    @classrooms = current_user.classrooms
    @subjects = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
    end
  end

  def list
    @classroom = Classroom.find(params[:classroom_id])
    @students = []
      @classroom.users.each do |user|
        if user.type == 'Student'
            @students << user
        end
      end
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
