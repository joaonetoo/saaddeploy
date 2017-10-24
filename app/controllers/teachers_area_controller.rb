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
    @anos = []
    @semestres = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @users = @students
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
    setup_search
  end

  def send_atividade_extra
    @classrooms = current_user.classrooms
    # @subjects =@classrooms.each.map(&:subject).uniq
    @subjects = []
    @students = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}
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
    @enviar= true
    if params[:arquivo] != "application/pdf" && params[:arquivo] != "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      @enviar=false
    end
    @atividade_extra = AtividadeExtra.new
    @atividade_extra.titulo = params[:titulo]
    @atividade_extra.descricao = params[:descricao]
    @atividade_extra.data_final =params[:data_final].to_a.sort.collect{|c| c[1]}.join("-")
    @atividade_extra.arquivo = params[:arquivo]
    current_user.sent_atividade_extras << @atividade_extra
    @atividade_extra.sender = current_user
    @atividade_extra.save

    if @atividade_extra.arquivo_content_type != "application/pdf" && @atividade_extra.arquivo_content_type != "application/vnd.openxmlformats-officedocument.wordprocessingml.document" && @atividade_extra.arquivo_content_type != "application/msword" 
      @enviar=false
      @atividade_extra.destroy
      redirect_to teachers_area_send_atividade_extra_path , alert: 'Não foi possivel cadastrar a atividade, insira um arquivo do tipo pdf ou word.' 
    else 

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

        redirect_to teachers_area_list_atividades_path, notice: 'Atividade Cadastrada.' 
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

  def search_learning
    setup_search
  end

  def search_analytics
    setup_search
  end

  def list
    @students = []
    if params[:subject_id] == 'todos'
      @classrooms = current_user.classrooms
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @subject = Subject.where(id: params[:subject_id]).first
      @selecao = @subject.nome
    end

    @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @students << user
          end
      end
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @students = []
      @classroom.users.each do |user|
        if(user.type == 'Student')
          @students << user
        end
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @students = []
      @students << @user
      @selecao = @students.first.nome
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
    @temResultados=false
    @student = @plano.user
    if @student.learning_results != nil && @student.learning_results.length > 0
      @learning_result = @student.learning_results.last
      @mediaDi = ((@learning_result.ec + @learning_result.or) / 2)
      @mediaAc = ((@learning_result.ec + @learning_result.ea) / 2)
      @mediaAs = ((@learning_result.or + @learning_result.ca) / 2)
      @mediaCo = ((@learning_result.ea + @learning_result.ca) / 2)
      @predominantes = {"co" => @mediaCo, "ac" => @mediaAc, "as" => @mediaAs, "di" => @mediaDi }.sort_by{ |k, v| v }.reverse.to_h
      @predominante1 = LearningStyle.where(sigla: @predominantes.keys[0]).first
      @predominante2 = LearningStyle.where(sigla: @predominantes.keys[1]).first
      @temResultados = true
    end
    if @student.results != nil && @student.results.length > 0
      @result = @student.results.last
      #@ancora1 = @result.anchors[0]
      #@descricao = @ancora1.descricao.gsub("\n", '')
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
          #pdf.image "#{@student.avatar.path(:thumb)}", :scale => 0.75
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Plano de Carreira",:color => "#778899", :align => :center, :size => 18
          pdf.move_down 40
          pdf.font("Times-Roman")
          pdf.text "<b>Nome:</b> #{@student.nome.capitalize}" , :color => "#778899", :align => :left, :size => 14, :inline_format => true
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

          if (@temResultados)
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
  def list_case_alunos
    @line_cases = []
    @cases = LineCase.all
    @cases.each do |c|
      if c.user_id == current_user.id
        @line_cases << c
      end
    end
  end

  def case_alunos
    @line_case = LineCase.find(params[:line_case])
    @users = @line_case.users
  end
  def case_questions
    @answer_cases = []
    @line_case = LineCase.find(params[:line_case])
    @user = User.find(params[:user_id])
    @questions = @line_case.questions
    @questions.each do |question|
      ac = question.answer_cases
      ac.each do |answer|
        if answer.user_id == @user.id
          @answer_cases << answer
        end
      end 
    end
  end
  def add_note
    respond_to do |format|
        format.js {}
    end
  end

end
