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
    @allUsers = false
    current_user.learning_results.each do |result|
      @results << result
    end

    @datas = @results.map(&:data_final).uniq
    @test= []
    @datas.each do |d|
      d = l(d, format: :long)
      @test << d
    end

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
    @allUsers = false
    @allUsers2 = false
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

  def classrooms
    @classrooms = current_user.classrooms
  end

  def classroom_show
    @classroom = Classroom.find(params[:classroom])
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
        @objective = Objective.new
        @weakness_answer= WeaknessAnswer.new
        @strategy = Strategy.new
        @strength_answer = StrengthAnswer.new
        @opportunity_answer = OpportunityAnswer.new
        @threats_answer = ThreatsAnswer.new
        @threats = @plano.threats
        @objectives = @plano.objectives
        @strengths = @plano.strengths
        @weaknesses = @plano.weaknesses
        @opportunities = @plano.opportunities
        @strength_notes = Note.where(recipient: current_user, topico: 'strengths')
        @opportunity_notes = Note.where(recipient: current_user, topico: 'opportunities')
        @weakness_notes = Note.where(recipient: current_user, topico: 'weaknesses')
        @threat_notes = Note.where(recipient: current_user, topico: 'threats')
        @mission_notes = Note.where(recipient: current_user, topico: 'mission')
        @objective_notes = Note.where(recipient: current_user, topico: 'objetivos')
    end
  end

  def pdf_plan
    @plano = current_user.plano
    if current_user.learning_results != nil && current_user.learning_results.length > 0
      @learning_result = current_user.learning_results.last
      @mediaDi = ((@learning_result.ec + @learning_result.or) / 2)
      @mediaAc = ((@learning_result.ec + @learning_result.ea) / 2)
      @mediaAs = ((@learning_result.or + @learning_result.ca) / 2)
      @mediaCo = ((@learning_result.ea + @learning_result.ca) / 2)
      @predominantes = {"co" => @mediaCo, "ac" => @mediaAc, "as" => @mediaAs, "di" => @mediaDi }.sort_by{ |k, v| v }.reverse.to_h
      @predominante1 = LearningStyle.where(sigla: @predominantes.keys[0]).first
      @predominante2 = LearningStyle.where(sigla: @predominantes.keys[1]).first
    end
    if current_user.results != nil && current_user.results.length > 0
      @result = current_user.results.last
      @ancora1 = @result.anchors[0]
      @descricao = @ancora1.descricao.gsub("\n", '')
    end
    respond_to do |format|
      format.html
      format.pdf {
        pdf = Prawn::Document.new
          #pdf.image "#{current_user.avatar.path(:thumb)}", :scale => 0.75

          pdf.font("Helvetica", :style => :bold)
          pdf.text "Nome do aluno: #{current_user.nome.capitalize}", :color => "006699", :align => :center, :size => 18
          if current_user.learning_results != nil && current_user.learning_results.length > 0
            pdf.move_down 40
            pdf.text "Primeiro estilo predominante: #{@predominante1.nome}",:color => "006699", :align => :left, :size => 16
            pdf.move_down 20
            pdf.font("Helvetica")
            pdf.text "#{@predominante1.descricao}", :align => :left, :size => 12
            pdf.move_down 40
            pdf.font("Helvetica", :style => :bold)
          end
          if current_user.results != nil && current_user.results.length > 0
            pdf.text "Âncora de carreira: #{@ancora1.nome}",:color => "006699", :align => :left, :size => 16
            pdf.move_down 20
            pdf.font("Helvetica")
            pdf.text "#{@descricao}", :align => :left, :size => 12
          end
          pdf.move_down 40
          pdf.font("Helvetica", :style => :bold)
          pdf.text "Plano de carreira",:color => "006699", :align => :left, :size => 16
          pdf.move_down 5
          pdf.text "Minha Missão", :color => "006699",:align => :left, :size => 14
          pdf.move_down 5
           pdf.font("Helvetica")
              pdf.text "#{@plano.mission}", :align => :left, :size => 12
          pdf.move_down 20

          pdf.font("Helvetica", :style => :bold)
          pdf.text "Ameaças", :color => "006699",:align => :left, :size => 14
          pdf.move_down 5

          @plano.threats.each do |threat|

              pdf.font("Helvetica")
              pdf.text "#{threat.text}", :align => :left, :size => 12
              pdf.font("Helvetica", :style => :bold)

              pdf.move_down 20
              pdf.font("Helvetica")
              pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
              pdf.move_down 5
              threat.threats_answers.each do |answer|
                pdf.move_down 5
                pdf.font("Helvetica")
                pdf.text "#{answer.text}", :align => :left, :size => 12

                pdf.move_down 20
            end
          end


          pdf.font("Helvetica", :style => :bold)
          pdf.text "Oportunidades", :color => "006699",:align => :left, :size => 14
          pdf.move_down 5
        @plano.opportunities.each do |opportunity|
          pdf.font("Helvetica")
          pdf.text "#{opportunity.text}", :align => :left, :size => 12
          pdf.move_down 20
          pdf.font("Helvetica")
            pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
            pdf.move_down 5
          opportunity.opportunity_answers.each do |answer|
            pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{answer.text}", :align => :left, :size => 12

            pdf.move_down 20
          end
        end


            pdf.font("Helvetica", :style => :bold)
            pdf.text "Fraquezas", :color => "006699",:align => :left, :size => 14
             pdf.move_down 5
          @plano.weaknesses.each do |weakness|
            pdf.font("Helvetica")
            pdf.text "#{weakness.text}", :align => :left, :size => 12

            pdf.move_down 20

            pdf.font("Helvetica")
            pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
            pdf.move_down 5
            weakness.weakness_answers.each do |answer|
            pdf.font("Helvetica", :style => :bold)
            pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{answer.text}", :align => :left, :size => 12

            pdf.move_down 20
          end
        end
          pdf.move_down 40
          pdf.font("Helvetica", :style => :bold)
          pdf.text "Forças", :color => "006699",:align => :left, :size => 14
           pdf.move_down 5
        @plano.strengths.each do |strength|
          pdf.font("Helvetica")
          pdf.text "#{strength.text}", :align => :left, :size => 12

          pdf.move_down 20
          pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
          pdf.move_down 5
          strength.strength_answers.each do |answer|
            pdf.font("Helvetica", :style => :bold)
             pdf.move_down 5
            pdf.font("Helvetica")
            pdf.text "#{answer.text}", :align => :left, :size => 12

            pdf.move_down 20
          end
         end

        @objectives = []
        @strategies = []
        @deadlines = []
        @factors = []
        @resources = []

        @plano.objectives.each do |objective|
          @objectives << objective.text
          @deadlines << objective.data
          objective.strategies.each do |strategy|
            @strategies << strategy.text
            @factors << strategy.factor
            @resources << strategy.resource
         end
         end
         pdf.font("Helvetica", :style => :bold)
        pdf.text "Plano de ação: ", :color => "006699", :align => :left, :size => 14
        pdf.font("Helvetica")
         @objetivo = @objectives.join("\n")
         @estrategia = @strategies.join("\n")
         @prazo = @deadlines.join("\n")
         @fatores = @factors.join("\n")
         @recursos = @resources.join("\n")

          data = [ ["Objetivos", "Estratégias", "Prazos", "Fatores Críticos de sucesso", "Recursos" ],[@objetivo, @estrategia, @prazo, @fatores, @recursos]]
          pdf.table(data)
          pdf.move_down 20
        send_data pdf.render, filename: 'plan.pdf', type: 'application/pdf', disposition: "inline"
      }
    end
  end
end
