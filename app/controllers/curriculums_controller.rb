class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:create_message,:create_networks]
  skip_before_action :authenticate_user!, only:[:all_curriculums,:show,:generate_curriculum]
  layout "curriculo", only: [:show]
  autocomplete :user, :nome, :full => true


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
     unless curriculum.user_id.nil?
      student = User.find(curriculum.user_id)
      @students << student
     end
    end
  end
  def search_user
    @user = User.where("lower(nome) LIKE ?", "%#{params[:user_id].downcase}%").first
    if not @user.nil?
      redirect_to all_curriculums_curriculums_path, notice:  "#{@user.nome} adicionado(a)."
    elsif
      redirect_to all_curriculums_curriculums_path, notice:" adicionado(a)."
    end
  end
  def create_networks
    @curriculum.update(curriculums_params)
    respond_to do |format|
      format.html { redirect_to student_area_edit_curriculo_path }
    end
  end

  def generate_curriculum
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
    if params[:generate] == "yes"
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
        else
              @ancora1 = Anchorinfo.where(tipo: @maior2).first
        end
        @descricao = @ancora1.descricao.gsub("\n", '')
      end
    end
    respond_to do |format|
      format.pdf {
        pdf = Prawn::Document.new :page_size=> "A4", :background => "public/bg_folder.jpg"
          date = DateTime.now
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Currículo gerado em #{ date.strftime('%d/%m/%Y às %H:%M')}", :color => "#778899", :align => :right 

          if @usuario.avatar.url == "/assets/semfoto.png"
            pdf.image "app/assets/images/semfoto.png",width: 75, height: 75, position: :left
          else 
            image = @usuario.avatar.url(:thumb)
            array_image = image.split("/")
            tamanho_array = array_image.length
            array_image[tamanho_array -1] = @usuario.avatar_file_name
            image = ""
            tamanho_array.times do |i|
              if i == tamanho_array -1
                image += "#{array_image[i]}"
              else
                image += "#{array_image[i]}/"
              end
            end
            #pdf.image "app/assets/images/saad.png",width: 35, height: 35, position: :left
            pdf.image "#{Rails.root}/public#{image}",width: 75, height: 75
          end
          temResultados = false
          pdf.font("Times-Roman")
          pdf.text_box "<b>Nome:</b> #{@usuario.nome.capitalize}",:size => 14,:at => [80, 755], :inline_format => true
          curso = Course.where(id: @usuario.course_id)
          pdf.text_box "<b>Curso:</b> #{@usuario.course.nome}" , :size => 14,:at => [80, 740], :inline_format => true
          pdf.text_box "<b>Email:</b> #{@usuario.email}" , :size => 14,:at => [80, 725], :inline_format => true
          pdf.text_box "<b>Telefone:</b> #{@usuario.telefone}" , :size => 14,:at => [80, 710], :inline_format => true
          pdf.text_box "<b>Endereço:</b> #{@usuario.endereco}" , :size => 14,:at => [80, 695], :inline_format => true
          pdf.move_down 20
          pdf.text "Resumo", :color => "#778899", :size => 14, :align => :center, :style => :bold
          pdf.move_down 10
          pdf.text "#{@curriculum.message}"
          if params[:generate] == "yes"
            pdf.move_down 40
            pdf.font("Times-Roman", :style => :bold)
            pdf.text "Âncora de Carreira e Estilo de Aprendizagem", :color => "#778899", :align => :center, :size => 14
            if @usuario.learning_results != nil && @usuario.learning_results.length > 0 && @usuario.results != nil && @usuario.results.length > 0
                temResultados = true
            end
            if (temResultados)
              pdf.move_down 5
              pdf.font("Times-Roman")
              ancorasEEstilos = [["Estilo de Aprendizagem Predominante: #{@predominante1.nome} " , "Âncora de Carreira Predominante: #{@ancora1.nome}"],[@predominante1.descricao,@descricao]]
              pdf.table(ancorasEEstilos)
            end
          end
          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Objetivos", :color => "#778899", :align => :center, :size => 14
          pdf.font("Times-Roman")
          @purposes.each do |purpose|
            pdf.move_down 10
            pdf.text "<b>•</b> #{purpose.description}",  :inline_format => true
          end
          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Competências", :color => "#778899", :size =>14, :align => :center
          pdf.font("Times-Roman")
          @skills.each do |skill|
            pdf.move_down 10
            pdf.text "<b>•</b> #{skill.description}", :inline_format => true
          end
          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Formação", :color => "#778899", :size => 14, :align => :center
          pdf.font("Times-Roman")
          @formations.each do |formation|
            pdf.move_down 10
            if formation.date_end.nil? 
              date_end = "Em andamento"
              
            else
               date_end = formation.date_end.strftime("%d/%m/%Y") 
            end
            pdf.text "#{formation.nivel} <b>-</b> #{formation.institution} <b>-</b> #{formation.course}", :inline_format => true
            pdf.text "Período: #{formation.date_start.strftime('%d/%m/%Y')} <b> - </b> #{date_end}", :inline_format => true
          end
          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Experiências", :color => "#778899", :size => 14, :align => :center
          pdf.font("Times-Roman")
          @experiences.each do |experience|
            pdf.move_down 10
            pdf.text "Instituição: #{experience.institution} <b> - </b> Função: #{experience.office} <b> - </b> Período: #{experience.date_start.strftime('%d/%m/%Y')} à #{experience.date_end.strftime('%d/%m/%Y')}" , :inline_format => true
            pdf.text "Resumo da experência: #{experience.description}"
          end

          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Qualificações Complementares", :color => "#778899", :size => 14, :align => :center
          pdf.font("Times-Roman")
          @qualifications.each do |qualification|
            pdf.move_down 10
            pdf.text "<b>•</b> #{qualification.description}", :inline_format => true
          end

          pdf.move_down 40
          pdf.font("Times-Roman", :style => :bold)
          pdf.text "Idiomas", :color=> "#778899", :size => 14, :align => :center
          pdf.font("Times-Roman")
          @languages.each do |language|
            pdf.move_down 10
            pdf.text "<b> #{language.idioma} - </b> Compreende: #{language.understand} <b> - </b> Fala: #{language.speak} <b> - </b> Lê: #{language.read} <b> - </b> Escreve : #{language.write}", :inline_format => true
          end
          send_data pdf.render, filename: 'curriculo.pdf', type: 'application/pdf', disposition: "inline"

        }
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
