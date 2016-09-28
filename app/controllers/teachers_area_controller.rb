class TeachersAreaController < ApplicationController
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
    @classrooms = current_user.classrooms
    @institutions << @institution
    @courses << @course
    @centers << @center
    @campus << @campu
    @subjects = []
    @students = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
            if user.type == 'Student'
            @students << user
        end
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}
  end

  def index
    @classrooms = current_user.classrooms
    @quizzes = current_user.quizzes
    @my_learning_results = current_user.learning_results
    @results = Result.where(user_id: current_user).find_each.to_a
    @my_quizzes = []
    @quizzes.each do |quiz|
        @equal = false
        if @results.size > 0
            @results.each do |result|
                if result.data_final == quiz.data_final
                    @equal = true
                end
            end
            if @equal == false
                @my_quizzes << quiz
            end
        else
                @my_quizzes << quiz
        end
        end

    @learning_quizzes = current_user.learning_quizzes
    @learning_results = LearningResult.where(user_id: current_user).find_each.to_a
    @my_learning_quizzes = []
    @learning_quizzes.each do |quiz|
        @equal = false
        if @learning_results.size > 0
            @learning_results.each do |result|
                if result.data_final == quiz.data_final
                    @equal = true
                end
            end
            if @equal == false
                @my_learning_quizzes << quiz
            end
        else
                @my_learning_quizzes << quiz
        end
    end
  end

  def videos_index
    @videos = current_user.sent_videos
  end

  def send_video
    @classrooms = current_user.classrooms
    @subjects =@classrooms.each.map(&:subject).uniq
  end

  def send_atividade_extra
    @classrooms = current_user.classrooms
    @subjects =@classrooms.each.map(&:subject).uniq
  end

  def list_atividades
    AtividadeExtra.close
    @atividades = current_user.sent_atividade_extras
  end

  def aprove_answer
    @atividade = AtividadeExtra.find(params[:atividade])
    @answer = Answer.find(params[:answer])
    @answer.status = "finalizado"
    @answer.save
    redirect_to @atividade
  end

  def create_atividade_extra
    @atividade_extra = AtividadeExtra.new
    @atividade_extra.titulo = params[:titulo]
    @atividade_extra.descricao = params[:descricao]
    @atividade_extra.data_final =params[:data_final].to_a.sort.collect{|c| c[1]}.join("-")
    @atividade_extra.arquivo = params[:arquivo]
    current_user.sent_atividade_extras << @atividade_extra
    @atividade_extra.sender = current_user
    @atividade_extra.save


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
          @atividade_extra.recipients << user
        end
    end
  end

  def create_video
    @video = Video.new
    @video.titulo = params[:titulo]
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
    setup_search
  end

  def search_learning
    setup_search
  end

  def search_analytics
    setup_search
  end

  def list
    @students = []
    if params[:classroom_id] == 'todos'
      @selecao = 'todos'
      @classrooms = current_user.classrooms
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
    @plano = Plano.find(params[:plano])
    student = User.find(@plano.user.id)
    respond_to do |format|
      format.html
      format.pdf {
        pdf = Prawn::Document.new
          #pdf.image "#{student.avatar.path(:thumb)}", :scale => 0.75

          pdf.font("Helvetica", :style => :bold)
          pdf.text "Nome do aluno: #{@plano.user.nome.capitalize}", :align => :center, :size => 14
          pdf.move_down 40

          pdf.text "1.0 Ameaças", :align => :left, :size => 12
          pdf.move_down 5

          @plano.threats.each do |threat|

              pdf.font("Helvetica")
              pdf.text "#{threat.text}", :align => :left, :size => 10
              pdf.font("Helvetica", :style => :bold)

               pdf.move_down 20
              threat.threats_answers.each do |answer|


                pdf.text "Resposta Ameaça", :align => :left, :size => 10
                pdf.move_down 5

                pdf.font("Helvetica")
                pdf.text "#{answer.text}", :align => :left, :size => 10

                pdf.move_down 20
            end
          end


          pdf.font("Helvetica", :style => :bold)
          pdf.text "2.0 oportunidades", :align => :left, :size => 12
          pdf.move_down 5
        @plano.opportunities.each do |opportunity|
          pdf.font("Helvetica")
          pdf.text "#{opportunity.text}", :align => :left, :size => 10
          pdf.move_down 20

          opportunity.opportunity_answers.each do |answer|

            pdf.font("Helvetica", :style => :bold)
            pdf.text "Resposta oportunidade:", :align => :left, :size => 10
            pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{answer.text}", :align => :left, :size => 10

            pdf.move_down 20
          end
        end


            pdf.font("Helvetica", :style => :bold)
            pdf.text "3.0 fraquezas", :align => :left, :size => 12
             pdf.move_down 5
          @plano.weaknesses.each do |weakness|
            pdf.font("Helvetica")
            pdf.text "#{weakness.text}", :align => :left, :size => 10

            pdf.move_down 20

            weakness.weakness_answers.each do |answer|

            pdf.font("Helvetica", :style => :bold)
            pdf.text "Resposta Fraqueza", :align => :left, :size => 10
            pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{answer.text}", :align => :left, :size => 10

            pdf.move_down 20
          end
        end

          pdf.font("Helvetica", :style => :bold)
          pdf.text "4.0 Forças", :align => :left, :size => 12
           pdf.move_down 5
        @plano.strengths.each do |strength|
          pdf.font("Helvetica")
          pdf.text "#{strength.text}", :align => :left, :size => 10

          pdf.move_down 20

          strength.strength_answers.each do |answer|
            pdf.font("Helvetica", :style => :bold)
            pdf.text "Resposta Força", :align => :left, :size => 10
             pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{answer.text}", :align => :left, :size => 10

            pdf.move_down 20
          end
         end

          pdf.font("Helvetica", :style => :bold)
          pdf.text "6.0 Meus objetivos ", :align => :left, :size => 12

          pdf.move_down 10
        @plano.objectives.each do |objective|
          pdf.font("Helvetica")
          pdf.text "#{objective.text}, Data limite planejada: #{objective.data}", :align => :left, :size => 10

          pdf.move_down 20

          objective.strategies.each do |strategy|

            pdf.font("Helvetica", :style => :bold)
            pdf.text "Estratégias: ", :align => :left, :size => 12
            pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{strategy.text}, Data limite: #{strategy.deadline}", :align => :left, :size => 10
            pdf.move_down 10
         end
         end

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
