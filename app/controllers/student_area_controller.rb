class StudentAreaController < ApplicationController
require "prawn/measurement_extensions"
layout "curriculo", only: [:curriculo,:edit_curriculo]
before_action :create_curriculum, only: [:edit_curriculo]

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
  def curriculo
    @usuario = current_user
  end
  def edit_curriculo
    @usuario = current_user
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
    @temResultados = false
    if current_user.learning_results != nil && current_user.learning_results.length > 0 && current_user.results != nil && current_user.results.length > 0
        @temResultados = true
    end
    if @temResultados
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

def create_curriculum
    verify_curriculum = Curriculum.where(user_id: current_user.id)
    if verify_curriculum.blank?
      @curriculo = Curriculum.new
      @curriculo.user_id = current_user.id
      @curriculo.save
    end
end

  def compare_anchors
    @selecao = current_user.nome
    @results = []
    @allUsers = false
    @allUsers2 = false
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

  def list_cases
    @line_cases = []
    @cases = LineCase.all
    @cases.each do |c|
      c.users.each do |user|
        if user == current_user
          @line_cases << c
        end
      end
    end
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
    @allUsers = false
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
      hash = {"tf" => @result.tf, "gm" => @result.gm, "au" => @result.au, "se" => @result.se, "ec" => @result.ec, "sv" => @result.sv, "ch" => @result.ch, "ls" => @result.ls}
      @maiores = hash.max_by(2){|k,v| v}
      num1 = @maiores[0][1]
      num2 = @maiores[1][1]
      @maior1 = @maiores[0][0]
      @maior2 = @maiores[1][0]
      if num1 > num2
            @ancora1 = Anchorinfo.where(tipo: @maior1).first
      else
            @ancora1 = Anchorinfo.where(tipo: @maior2).first
      end
      @descricao = @ancora1.descricao.gsub("\n", '')

  end
    respond_to do |format|
      format.html
      format.pdf {
        pdf = Prawn::Document.new :page_size=> "A4", :background => "public/bg_folder.jpg"
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Plano de Carreira",:color => "#778899", :align => :center, :size => 18
          pdf.move_down 40
          temResultados = false
          pdf.font("Times-Roman")
          pdf.text "<b>Nome:</b> #{current_user.nome.capitalize}" , :color => "#778899", :align => :left, :size => 14, :inline_format => true
          curso = Course.where(id: current_user.course_id)
          pdf.text "<b>Curso:</b> #{current_user.course.nome}" , :color => "#778899", :align => :left, :size => 14, :inline_format => true
          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Âncora de Carreira e Estilo de Aprendizagem", :color => "#778899", :align => :left, :size => 14
          # if current_user.learning_results != nil && current_user.learning_results.length > 0
            # pdf.move_down 40
            # pdf.text "Estilo de Aprendizagem Predominante: #{@predominante1.nome}",:color => "006699", :align => :left, :size => 16
            # pdf.move_down 20
            # pdf.font("Helvetica")
            # pdf.text "#{@predominante1.descricao}", :align => :left, :size => 12
            # pdf.move_down 40
            # pdf.font("Helvetica", :style => :bold)

          # end
          # if current_user.results != nil && current_user.results.length > 0
          #   # pdf.text "Âncora de carreira: #{@ancora1.nome}",:color => "006699", :align => :left, :size => 16
          #   # pdf.move_down 20
          #   # pdf.font("Helvetica")
          #   # pdf.text "#{@descricao}", :align => :left, :size => 12
          # end
          if current_user.learning_results != nil && current_user.learning_results.length > 0 && current_user.results != nil && current_user.results.length > 0
              temResultados = true
          end


          if (temResultados)
            pdf.move_down 5
            pdf.font("Times-Roman")
            ancorasEEstilos = [["Estilo de Aprendizagem Predominante: #{@predominante1.nome} " , "Âncora de Carreira Predominante: #{@ancora1.nome}"],[@predominante1.descricao,@descricao]]
            pdf.table(ancorasEEstilos)
          end
          pdf.move_down 20
          pdf.text "Minha Missão", :color => "#778899",:align => :left, :size => 14 ,:style => :bold
          pdf.move_down 5
              pdf.text "#{@plano.mission}", :align => :left, :size => 12
          pdf.move_down 20

          pdf.text "Ameaças", :color => "#778899",:align => :left, :size => 14 ,:style => :bold
          pdf.move_down 5
          # @plano.threats.each do |threat|

          #     pdf.font("Helvetica")
          #     pdf.text "#{threat.text}", :align => :left, :size => 12
          #     pdf.font("Helvetica", :style => :bold)

          #     pdf.move_down 20
          #     pdf.font("Helvetica")
          #     pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
          #     pdf.move_down 5
          #     threat.threats_answers.each do |answer|
          #       pdf.move_down 5
          #       pdf.font("Helvetica")
          #       pdf.text "#{answer.text}", :align => :left, :size => 12

          #       pdf.move_down 20
          #   end
          # end
          @threatAndAnswer =[["<b><i>Ameaças</i></b>","<b><i>Respostas às Ameaças</i></b>"]]
          @threat1 = ""
          @answer1 = ""
          @plano.threats.each do |threat|
            @threat1 += threat.text
          threat.threats_answers.each do |answer|
               @answer1 +=answer.text 
               @answer1 += "\n"
            end
            threatAndAnswerTemporary= [@threat1,@answer1]
            @threatAndAnswer<<threatAndAnswerTemporary
          @threat1 = ""
          @answer1 = ""

          end
          #se der algum problema provavelmente vai ser pelo formato inline
          pdf.table(@threatAndAnswer ,:column_widths => [261,261],:cell_style => { :font => "Times-Roman", :inline_format => true  })
        #   pdf.font("Helvetica", :style => :bold)
        #   pdf.text "Oportunidades", :color => "006699",:align => :left, :size => 14
        #   pdf.move_down 5
        # @plano.opportunities.each do |opportunity|
        #   pdf.font("Helvetica")
        #   pdf.text "#{opportunity.text}", :align => :left, :size => 12
        #   pdf.move_down 20
        #   pdf.font("Helvetica")
        #     pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
        #     pdf.move_down 5
        #   opportunity.opportunity_answers.each do |answer|
        #     pdf.move_down 5
        #     pdf.font("Helvetica")
        #     pdf.text "#{answer.text}", :align => :left, :size => 12

        #     pdf.move_down 20
        
        #   end
        # end
        pdf.move_down(20)
        pdf.text "Oportunidades", :color => "#778899",:align => :left, :size => 14 ,:style => :bold
        pdf.move_down(5)
         @opportunitiesAndAnswer = [["<b><i>Oportunidades</b></i>","<b><i>Respostas às oportunidades</b></i>"]]
          @opportunity1=""
          @answerOpportunity = ""
          @plano.opportunities.each do |opportunity|
            @opportunity1 = opportunity.text
            opportunity.opportunity_answers.each do |answer|
              @answerOpportunity += answer.text
              @answerOpportunity += "\n"
            end
            oportunityAndAnswerTemporary = [@opportunity1,@answerOpportunity]
           @opportunitiesAndAnswer << oportunityAndAnswerTemporary
           @opportunity1=""
           @answerOpportunity = ""
          end
          pdf.table(@opportunitiesAndAnswer ,:column_widths => [261,261],:cell_style => { :font => "Times-Roman", :inline_format => true  })

        #     pdf.font("Helvetica", :style => :bold)
        #     pdf.text "Fraquezas", :color => "006699",:align => :left, :size => 14
        #      pdf.move_down 5
        #   @plano.weaknesses.each do |weakness|
        #     pdf.font("Helvetica")
        #     pdf.text "#{weakness.tet}", :align => :left, :size => 12

        #     pdf.move_down 20

        #     pdf.font("Helvetica")
        #     pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
        #     pdf.move_down 5
        #     weakness.weakness_answers.each do |answer|
        #     pdf.font("Helvetica", :style => :bold)
        #     pdf.move_down 5
        #     pdf.font("Helvetica")
        #     pdf.text "#{answer.text}", :align => :left, :size => 12

        #     pdf.move_down 20
        #   end
        # end
          pdf.move_down(20)
        pdf.text "Fraquezas", :color => "#778899",:align => :left, :size => 14 ,:style => :bold
          @weaknessesAndAnswer = [["<b><i>Fraquezas</i></b>","<b><i>Respostas às Fraquezas</i></b>"]]
          pdf.move_down(5)
          @weakness1=""
          @answerWeakness=""
          @plano.weaknesses.each do |weakness|
            @weakness1 = weakness.text
            weakness.weakness_answers.each do |answer|
              @answerWeakness += answer.text
              @answerWeakness += "\n"
            end
            weaknessesAndAnswerTemporary = [@weakness1,@answerWeakness]
            @weaknessesAndAnswer << weaknessesAndAnswerTemporary
            @weakness1=""
            @answerWeakness=""
          end
          pdf.table(@weaknessesAndAnswer ,:column_widths => [261,261],:cell_style => { :font => "Times-Roman", :inline_format => true  })
        #   pdf.move_down 40
        #   pdf.font("Helvetica", :style => :bold)
        #   pdf.text "Forças", :color => "006699",:align => :left, :size => 14
        #    pdf.move_down 5
        # @plano.strengths.each do |strength|
        #   pdf.font("Helvetica")
        #   pdf.text "#{strength.text}", :align => :left, :size => 12

        #   pdf.move_down 20
        #   pdf.text "Respostas", :color => "006699",:align => :left, :size => 14
        #   pdf.move_down 5
        #   strength.strength_answers.each do |answer|
        #     pdf.font("Helvetica", :style => :bold)
        #      pdf.move_down 5
        #     pdf.font("Helvetica")
        #     pdf.text "#{answer.text}", :align => :left, :size => 12

        #     pdf.move_down 20
        #   end
        #  end
        pdf.move_down(20)
        pdf.text "Forças", :color => "#778899",:align => :left, :size => 14 ,:style => :bold
        pdf.move_down(5)
        @strengthsAndAnswer = [["<b><i>Forças</i></b>","<b><i>Respostas às Fraquezas</i></b>"]]
        @strength1=""
        @answerStrength =""
        @plano.strengths.each do |strength|
          @strength1 = strength.text
          strength.strength_answers.each do |answer|
            @answerStrength += answer.text
            @answerStrength += "\n"
          end
          strengthsAndAnswerTemporary = [@strength1,@answerStrength]
          @strengthsAndAnswer << strengthsAndAnswerTemporary
          @strength1=""
          @answerStrength =""
        end
          pdf.table(@strengthsAndAnswer ,:column_widths => [261,261],:cell_style => { :font => "Times-Roman", :inline_format => true  })
        
        pdf.move_down(20)
        pdf.text "Plano de Ação", :color => "#778899",:align => :left, :size => 14 ,:style => :bold
        pdf.move_down(5)

        @objectives = []
        @strategies = []
        @deadlines = []
        @factors = []
        @resources = []
        objetivos1 =""
        data1 =""
        estrategia1=""
        fator1=""
        recurso1=""
         @planoAcao = [["<b><i>Objetivos</i></b>", "<b><i>Estratégias</i><b>", "<b><i>Prazos</i></b>", "<b><i>Fatores Críticos de sucesso</i></b>", "<b><i>Recursos</b></i>" ]]
          @plano.objectives.each  do |objective|
            objetivos1= objective.text
            data1 = objective.data.strftime("%d/%m/%Y")
            objective.strategies.each do |strategy|
              estrategia1 += strategy.text
              estrategia1 += "\n"
              fator1 += strategy.factor
              fator1 += "\n"
              recurso1 += strategy.resource
              recurso1 += "\n"
            end
            planoAcaoTemporario = [objetivos1, estrategia1, data1,fator1,recurso1]
            @planoAcao << planoAcaoTemporario
            objetivos1 =""
            data1 =""
            estrategia1=""
            fator1=""
            recurso1=""
          end
      pdf.table(@planoAcao ,:column_widths => [150,148,65,90,70],:cell_style => { :font => "Times-Roman", :inline_format => true  })

        # @plano.objectives.each do |objective|
        #   @objectives << objective.text
        #   @deadlines << objective.data
        #   objective.strategies.each do |strategy|
        #     @strategies << strategy.text
        #     @factors << strategy.factor
        #     @resources << strategy.resource
        #  end
        #  end
        #  pdf.font("Helvetica", :style => :bold)
        # pdf.text "Plano de ação: ", :color => "006699", :align => :left, :size => 14
        # pdf.font("Helvetica")
        #  @objetivo = @objectives.join("\n")
        #  @estrategia = @strategies.join("\n")
        #  @prazo = @deadlines.join("\n")
        #  @fatores = @factors.join("\n")
        #  @recursos = @resources.join("\n")


          pdf.move_down 20

        send_data pdf.render, filename: 'plan.pdf', type: 'application/pdf', disposition: "inline"
      }
    end
  end
end
