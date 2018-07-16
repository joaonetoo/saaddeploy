class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
require 'set'
require 'csv'
  # GET /results
  # GET /results.json
  def index
    @results = Result.all
  end

def setup_teacher_search
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
    @subjects = @subjects.sort_by{ |subject| subject.nome}
    @users = @students
    @students = @students.uniq { |s| s.nome}
    @students = @students.sort_by{ |student| student.nome}
    @students.each {|student| student.nome = student.nome.upcase}

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
    @subjects = @subjects.sort_by{ |subject| subject.nome}
    @students = @students.uniq { |s| s.nome}
    @students = @students.sort_by{ |student| student.nome}

  end
  # GET /results/1
  # GET /results/1.json
  def show
  end

  def compare_by_date
    @selecao = params[:selecao]
    @selecao2 = params[:selecao2]
    @allUsers = params[:allUsers]
    @results = []
    if @allUsers == 'false'
        @resultados = params[:results]
      @resultados.each do |result|
        pre = Result.where(data_final: params[:data_final], id: result).first
        if not pre.nil?
          @results << pre
        end
      end
    else
        @resultados = params[:users]
        @resultados.each do |i|
            pre = Result.where(user_id:  i)
            if not pre.blank?
              pre = pre.last
              @results << pre
            end
        end
    end

    @mediaTf = 0.0
    @mediaGm = 0.0
    @mediaAu = 0.0
    @mediaSe = 0.0
    @mediaEc = 0.0
    @mediaSv = 0.0
    @mediaCh = 0.0
    @mediaLs = 0.0
    @results.each do |result|
      @mediaTf = @mediaTf + result.tf
      @mediaGm = @mediaGm + result.gm
      @mediaAu = @mediaAu + result.au
      @mediaSe = @mediaSe + result.se
      @mediaEc = @mediaEc + result.ec
      @mediaSv = @mediaSv + result.sv
      @mediaCh = @mediaCh + result.ch
      @mediaLs = @mediaLs + result.ls
    end
    @mediaTf = @mediaTf / @results.size.to_f
    @mediaGm = @mediaGm / @results.size.to_f
    @mediaAu = @mediaAu / @results.size.to_f
    @mediaSe = @mediaSe / @results.size.to_f
    @mediaEc = @mediaEc / @results.size.to_f
    @mediaSv = @mediaSv / @results.size.to_f
    @mediaCh = @mediaCh / @results.size.to_f
    @mediaLs = @mediaLs / @results.size.to_f

    @media = {"Competência Técnica e Funcional" => @mediaTf, "Competência Administrativa Geral" => @mediaGm, "Autonomia e Independência" => @mediaAu,
      "Segurança e Estabilidade" => @mediaSe, "Criatividade Empresarial" => @mediaEc, "Dedicação a uma Causa" => @mediaSv, "Desafio Puro" => @mediaCh, "Estilo de Vida" => @mediaLs }.sort_by{ |k, v| v }.reverse.to_h
    if @results.size == 1
      if @results.first.anchors[0] != nil
         @ancora1 = @results.first.anchors[0]
         @ancora1Nome = @ancora1.nome
         @ancora1Descricao = @ancora1.descricao.gsub("\n", '')
         @ancora1Perspectiva = @ancora1.perspectiva.gsub("\n", '')
         @ancora1Perfil = @ancora1.perfil.gsub("\n", '')
      end
      if @results.first.anchors[1] != nil
       @ancora2 = @results.first.anchors[1]
       @ancora2Nome = @ancora2.nome
       @ancora2Descricao = @ancora2.descricao.gsub("\n", '')
       @ancora2Perspectiva = @ancora2.perspectiva.gsub("\n", '')
       @ancora2Perfil = @ancora2.perfil.gsub("\n", '')

      end
      @nomeUsuario = @results.first.user.nome.capitalize

    end

    #seleção 2
    @results2 = []
    @allUsers2 = params[:allUsers2]
    if  @allUsers2 == 'false'
      @resultados2 = params[:results2]
      @resultados2.each do |result|
        pre = Result.where(data_final: params[:data_final2], id: result).first
        if not pre.nil?
          @results2 << pre
        end
      end
    else
        @resultados2 = params[:users2]
        @resultados2.each do |i|
            pre = Result.where(user_id:  i)
            if not pre.blank?
              pre = pre.last
              @results2 << pre
            end
        end
    end

    @mediaTf2 = 0.0
    @mediaGm2 = 0.0
    @mediaAu2 = 0.0
    @mediaSe2 = 0.0
    @mediaEc2 = 0.0
    @mediaSv2 = 0.0
    @mediaCh2 = 0.0
    @mediaLs2 = 0.0
    @results2.each do |result|
      @mediaTf2 = @mediaTf2+ result.tf
      @mediaGm2 = @mediaGm2 + result.gm
      @mediaAu2 = @mediaAu2 + result.au
      @mediaSe2 = @mediaSe2 + result.se
      @mediaEc2 = @mediaEc2 + result.ec
      @mediaSv2 = @mediaSv2 + result.sv
      @mediaCh2 = @mediaCh2 + result.ch
      @mediaLs2 = @mediaLs2 + result.ls
    end
    @mediaTf2 = @mediaTf2 / @results2.size.to_f
    @mediaGm2 = @mediaGm2 / @results2.size.to_f
    @mediaAu2 = @mediaAu2 / @results2.size.to_f
    @mediaSe2 = @mediaSe2 / @results2.size.to_f
    @mediaEc2 = @mediaEc2 / @results2.size.to_f
    @mediaSv2 = @mediaSv2 / @results2.size.to_f
    @mediaCh2 = @mediaCh2 / @results2.size.to_f
    @mediaLs2 = @mediaLs2 / @results2.size.to_f

    @media2 = {"Competência Técnica e Funcional" => @mediaTf2, "Competência Administrativa Geral" => @mediaGm2, "Autonomia e Independência" => @mediaAu2,
      "Segurança e Estabilidade" => @mediaSe2, "Criatividade Empresarial" => @mediaEc2, "Dedicação a uma Causa" => @mediaSv2, "Desafio Puro" => @mediaCh2, "Estilo de Vida" => @mediaLs2 }.sort_by{ |k, v| v }.reverse.to_h
    if @results2.size == 1
      if @results2.first.anchors[0] != nil
         @ancora12 = @results2.first.anchors[0]
         @ancora1Nome2 = @ancora12.nome
         @ancora1Descricao2 = @ancora12.descricao.gsub("\n", '')
         @ancora1Perspectiva2 = @ancora12.perspectiva.gsub("\n", '')
         @ancora1Perfil2 = @ancora12.perfil.gsub("\n", '')
      end
      if @results2.first.anchors[1] != nil
       @ancora22 = @results2.first.anchors[1]
       @ancora2Nome2 = @ancora22.nome
       @ancora2Descricao2 = @ancora22.descricao.gsub("\n", '')
       @ancora2Perspectiva2 = @ancora22.perspectiva.gsub("\n", '')
       @ancora2Perfil2 = @ancora22.perfil.gsub("\n", '')

      end
      @nomeUsuario2 = @results2.first.user.nome.capitalize

    end


  end

  def show_by_date
    @results = []
    @allUsers = params[:allUsers]
    if  @allUsers == 'false'
      @resultados = params[:results]

      @selecao = params[:selecao]
      @resultados.each do |result|
        if params[:data_final]
          pre = Result.where(data_final: params[:data_final], id: result).first
        else
          pre = Result.find(result)
        end
        if not pre.nil?
          @results << pre
        end
      end
    end
    if @allUsers == 'true'
      @x = params[:users]
      @x.each do |i|
         pre = Result.where(user_id:  i)
            if not pre.blank?
              pre = pre.last
              @results << pre
            end
        end
    @results = @results.sort_by{ |result| result.user.nome}
    end

    @mediaTf = 0.0
    @mediaGm = 0.0
    @mediaAu = 0.0
    @mediaSe = 0.0
    @mediaEc = 0.0
    @mediaSv = 0.0
    @mediaCh = 0.0
    @mediaLs = 0.0
    @results.each do |result|
      @mediaTf = @mediaTf + result.tf
      @mediaGm = @mediaGm + result.gm
      @mediaAu = @mediaAu + result.au
      @mediaSe = @mediaSe + result.se
      @mediaEc = @mediaEc + result.ec
      @mediaSv = @mediaSv + result.sv
      @mediaCh = @mediaCh + result.ch
      @mediaLs = @mediaLs + result.ls
    end
    @mediaTf = @mediaTf / @results.size.to_f
    @mediaGm = @mediaGm / @results.size.to_f
    @mediaAu = @mediaAu / @results.size.to_f
    @mediaSe = @mediaSe / @results.size.to_f
    @mediaEc = @mediaEc / @results.size.to_f
    @mediaSv = @mediaSv / @results.size.to_f
    @mediaCh = @mediaCh / @results.size.to_f
    @mediaLs = @mediaLs / @results.size.to_f
    @media = {"Competência Técnica e Funcional" => @mediaTf, "Competência Administrativa Geral" => @mediaGm, "Autonomia e Independência" => @mediaAu,
      "Segurança e Estabilidade" => @mediaSe, "Criatividade Empresarial" => @mediaEc, "Dedicação a uma Causa" => @mediaSv, "Desafio Puro" => @mediaCh, "Estilo de Vida" => @mediaLs }.sort_by{ |k, v| v }.reverse.to_h
    if @results.size == 1
      if @results.first.anchors[0] != nil &&  @results.first.anchors[1] != nil
        @result = @results.first
        hash = {"tf" => @result.tf, "gm" => @result.gm, "au" => @result.au, "se" => @result.se, "ec" => @result.ec, "sv" => @result.sv, "ch" => @result.ch, "ls" => @result.ls}
        @maiores = hash.max_by(2){|k,v| v}
        num1 = @maiores[0][1]
        num2 = @maiores[1][1]
        @maior1 = @maiores[0][0]
        @maior2 = @maiores[1][0]
        if num1 >= num2
              @ancora1 = Anchorinfo.where(tipo: @maior1).first
              @ancora2 = Anchorinfo.where(tipo: @maior2).first
        else
              @ancora1 = Anchorinfo.where(tipo: @maior2).first
              @ancora2 = Anchorinfo.where(tipo: @maior1).first
        end
         @ancora1Nome = @ancora1.nome
         @ancora1Descricao = @ancora1.descricao.gsub("\n", '')
         @ancora1Perspectiva = @ancora1.perspectiva.gsub("\n", '')
         @ancora1Perfil = @ancora1.perfil.gsub("\n", '')
         @ancora2Nome = @ancora2.nome
         @ancora2Descricao = @ancora2.descricao.gsub("\n", '')
         @ancora2Perspectiva = @ancora2.perspectiva.gsub("\n", '')
         @ancora2Perfil = @ancora2.perfil.gsub("\n", '')
      end
      @nomeUsuario = @results.first.user.nome.capitalize

    end


    respond_to do |format|
      format.js {}
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="Resultados.xlsx"'
      }
    end
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
        @users = @students
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
    #eu alterei isso aqui
    @allUsers = false
    if params[:users_id] == 'todos'
      @allUsers = true
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

  def search
    if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).sort_by{ |subject| subject.nome}
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end

   def campu_selection
    @campu = Campu.find(params[:campu])
    @centers = @campu.centers
  end

  def campu2_selection
    @campu = Campu.find(params[:campu])
    @centers = @campu.centers
  end

  def center_selection
    @center = Center.find(params[:center])
    @courses = @center.courses
  end

  def center2_selection
    @center = Center.find(params[:center])
    @courses = @center.courses
  end

  def course_selection
    @course = Course.find(params[:course])
    @subjects = @course.subjects
  end

  def course2_selection
    @course = Course.find(params[:course])
    @subjects = @course.subjects
  end

  def subject_selection
    @subject = Subject.find(params[:subject])
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
    @anos = []
    @classrooms.each do |classroom|
        @anos << classroom.ano
    end
    respond_to do |format|
       format.js {  }
    end
  end

    def subject2_selection
    @subject = Subject.find(params[:subject])
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
    @anos = []
    @classrooms.each do |classroom|
        @anos << classroom.ano
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def ano_selection
    @ano = params[:ano]
    @subject = Subject.find(params[:subject])
    @semestres = []
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
    @classrooms.each do |classroom|
      if classroom.ano == @ano
        @semestres << classroom.semestre
      end
    end

    respond_to do |format|
       format.js {  }
    end
  end

  def ano2_selection
    @ano = params[:ano]
    @subject = Subject.find(params[:subject])
    @semestres = []
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
    @classrooms.each do |classroom|
      if classroom.ano == @ano
        @semestres << classroom.semestre
      end
    end

    respond_to do |format|
       format.js {  }
    end
  end

  def semestre_selection
    @semestre = params[:semestre]
    @subject = Subject.find(params[:subject])
    @classrooms = []
    if current_user.type == 'Teacher'
      @classrooms_pre = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms_pre << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || 'Principal'
      @classrooms_pre = @subject.classrooms
    end
    @classrooms_pre.each do |classroom|
      if classroom.semestre == @semestre
        @classrooms << classroom
      end
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def semestre2_selection
    @semestre = params[:semestre]
    @subject = Subject.find(params[:subject])
    @classrooms = []
    if current_user.type == 'Teacher'
      @classrooms_pre = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms_pre << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || 'Principal'
      @classrooms_pre = @subject.classrooms
    end
    @classrooms_pre.each do |classroom|
      if classroom.semestre == @semestre
        @classrooms << classroom
      end
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def classroom_selection
    @classroom = Classroom.find(params[:classroom])
    @users = @classroom.users.each {|user| user.nome = user.nome.mb_chars.upcase}
    @users = @users.sort_by {|user| user.nome}
  end

  def classroom2_selection
    @classroom = Classroom.find(params[:classroom])
    @users = @classroom.users.each {|user| user.nome = user.nome.mb_chars.upcase}
    @users = @users.sort_by {|user| user.nome}
  end

  def analytics
     if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).find_each
      @subjects = @subjects.sort_by{ |subject| subject.nome}
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end

  def analytic_list

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
        @users = @students
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

    @allUsers = false

    if params[:users_id] == 'todos'
      @allUsers = true
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


    #selecao2
    if params[:institution2_id] == 'todos'
      @users2 = User.where(type: 'Student').find_each
      @selecao2 = "todos os institutos"
    else
      @users2 = User.where(institution_id: params[:institution2_id], type: 'Student').all
      @institution2 = Institution.where(id: params[:institution2_id]).first
      @selecao2 = @institution2.nome
    end

    if params[:campu2_id] == 'todos' && params[:institution2_id] != 'todos'
      @campus2 = Campu.where(institution_id: params[:institution2_id]).find_each
      @institution2 = Institution.where(id: params[:institution2_id]).first
      @selecao2 = @institution2.nome
      @centers2 = []
      @campus2.each do |campus|
          @centers2 << Center.where(campu_id: campus.id)
      end
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.ids)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids, type: 'Student')
      end
      @users2 = @users2.first.to_a
    elsif params[:institution2_id] != 'todos'
      @campus2 = Campu.where(id: params[:campu2_id]).first
      @selecao2 = @campus2.name
      @centers2 = @campus2.centers.all
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.id)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids, type: 'Student')
      end
    end

    if params[:center2_id] == 'todos' && params[:campu2_id] != 'todos'
      @centers2 = Center.where(campu_id: params[:campu2_id]).find_each
      @campus2 = Campu.where(id: params[:campu2_id]).first
      @selecao2 = @campus2.name
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.id)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids,  type: 'Student')
      end
      @users2 = @users2.first.to_a


    elsif params[:center2_id] != 'todos' && params[:center2_id] != nil
      @center2 = Center.where(campu_id: params[:campu2_id]).first
      @selecao2 = @center2.name
      @courses2 = Course.where(center_id: params[:center2_id]).find_each
      @users2 = []
      @courses2.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users2 << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end
    end

    if params[:course2_id] != 'todos' && params[:center2_id] != nil && params[:center2_id] != 'todos'
      if current_user.type == 'Teacher'
        setup_teacher_search
        @users2 = @students
        @selecao2 = "todos os meus alunos"
      else
        @users2 = User.where(course_id: params[:course2_id], type: 'Student').find_each
        @users2 = @users2.to_a
        @course2 = Course.where(id: params[:course2_id]).first
        @selecao2 = @course2.nome
      end
    end

    if params[:subject2_id] != 'todos' && params[:subject2_id] != nil
      @subject2 = Subject.find(params[:subject2_id])
      if current_user.type == 'Teacher'
        @classrooms2 = []
        @subject2.classrooms.each do |classroom|
          classroom.users.each do |user|
            if user.id == current_user.id
              @classrooms2 << classroom
            end
          end
        end
      elsif current_user.type == 'Coordinator' || 'Principal'
        @classrooms2 = @subject2.classrooms
      end
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users2 << user
          end
        end
      end
      @selecao2 = @subject2.nome
    end
#ano
    if params[:ano2] != 'todos' && params[:ano2] != nil
      @ano2 = params[:ano2]
      if current_user.type == 'Teacher'
        @classrooms2 = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject2 && classroom.ano == @ano2
            @classrooms2 << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || 'Principal'
        @subject2.classrooms.each do |classroom|
          if classroom.ano == @ano2
            @classrooms2 << classroom
          end
        end
      end
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users2 << user
          end
        end
      end
      @selecao2 = "#{@subject2.nome}, #{@ano2}"
    end
#
#semestre
    if params[:semestre2] != 'todos' && params[:semestre2] != nil
      @semestre2 = params[:semestre2]
      if current_user.type == 'Teacher'
        @classrooms2 = []
          current_user.classrooms.each do |classroom|
          if classroom.subject == @subject2 && classroom.ano == @ano2 && classroom.semestre == @semestre2
            @classrooms2 << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || 'Principal'
        @subject2.classrooms.each do |classroom|
          if classroom.semestre == @semestre2 && classroom.ano == @ano2
            @classrooms2 << classroom
          end
        end
      end
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users2 << user
          end
        end
      end
      @selecao2 = "#{@semestre2} semestre, #{@ano2}, #{@subject2.nome}"
    end

    if params[:classroom2_id] != 'todos' && params[:classroom2_id] != nil
      @classroom2 = Classroom.where(id: params[:classroom2_id]).first
      @selecao2 = "turma " + @classroom2.codigo
      @users2 = []
      @classroom2.users.each do |user|
        if(user.type == 'Student')
          @users2 << user
        end
      end
    end

    if params[:users2_id] != 'todos' && params[:users2_id] != nil
      @user2 = User.where(id: params[:users2_id]).first
      @users2 = []
      @users2 << @user2
      @selecao2 = @users2.first.nome
    end
    @allUsers2 = false
    if params[:users2_id] == 'todos'
      @allUsers2 = true
    end

      if @users2 != nil
        @users2 = @users2.uniq
      @results2 = []
      @users2.each do |user|
          user.results.each do |result|
            @results2 << result
          end
      end

      @datas2 = @results2.map(&:data_final).uniq
    else
      redirect_to no_users_error_results_path, notice: 'Não há usuarios disponiveis para exibir'
    end

  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to welcome_index_path, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:data_final, :tf, :gm, :au, :se, :ec, :sv, :ch, :ls, :user_id, :quiz_id, :final_date)
    end
end
