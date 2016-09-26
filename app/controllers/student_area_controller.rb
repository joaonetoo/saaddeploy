class StudentAreaController < ApplicationController
require "prawn/measurement_extensions"

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
    if current_user.plano != nil
        @plano = current_user.plano
        @notes = Note.where(recipient: @plano.user).each.to_a
    end

    @atividades = current_user.received_atividade_extras
    @answers  = current_user.answers
  end

  def my_learning_result
    @selecao = current_user.nome
    @results = []
    current_user.learning_results.each do |result|
      @results << result
    end

    @datas = @results.map(&:data_final).uniq

  end

  def compare_anchors
    @selecao = current_user.nome
    @results = []
    current_user.results.each do |result|
      @results << result
    end

    @datas = @results.map(&:data_final).uniq

    @results2 = @results
    @datas2 = @datas
    @selecao2 = @selecao
  end

  def compare_learning
    @selecao = current_user.nome
    @results = []
          current_user.learning_results.each do |result|
            @results << result
          end

    @datas = @results.map(&:data_final).uniq
    @results2 = @results
    @datas2 = @datas
    @selecao2 = @selecao
  end

  def list_atividades
    AtividadeExtra.close
    @atividades = current_user.received_atividade_extras
  end

  def list_answers
    @atividade_extra = AtividadeExtra.find(params[:atividade_extra])
    @answers = Answer.where(:user => current_user, :atividade_extra => @atividade_extra)
  end

  def videos_index
    @videos = current_user.received_videos
  end

  def unsubscribe_video
    @video = Video.find(params[:video])
    @video.recipients.delete(current_user)
    redirect_to  student_area_videos_index_path
  end

  def my_result
    @selecao = current_user.nome
    @results = []
    current_user.results.each do |result|
      @results << result
    end

    @datas = @results.map(&:data_final).uniq
  end

  def my_plan
    if current_user.plano != nil
        @plano = current_user.plano
        @strength = Strength.new
        @threat = Threat.new
        @weakness = Weakness.new
        @opportunity = Opportunity.new
        @weakness_answer= WeaknessAnswer.new
        @strength_answer = StrengthAnswer.new
        @opportunity_answer = OpportunityAnswer.new
        @threats_answer = ThreatsAnswer.new
        @threats = @plano.threats
        @strengths = @plano.strengths
        @weaknesses = @plano.weaknesses
        @opportunities = @plano.opportunities
    end
  end

  def pdf_plan
    @plano = Plano.find(params[:plano])
    student = User.find(@plano.user.id)
    respond_to do |format|
      format.html
      format.pdf {
        pdf = Prawn::Document.new
          pdf.image "#{student.avatar.path(:thumb)}", :scale => 0.75

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
end
