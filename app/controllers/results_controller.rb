class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
require 'set'
require 'csv'
  # GET /results
  # GET /results.json
  def index
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  def compare_by_date
    @selecao = params[:selecao]
    @selecao2 = params[:selecao2]
    @resultados = params[:results]
    @results = []
    @resultados.each do |result|
      pre = Result.where(data_final: params[:data_final], id: result).first
      if not pre.nil?
        @results << pre
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

    @resultados2 = params[:results2]
    @results2 = []
    @resultados2.each do |result|
      pre = Result.where(data_final: params[:data_final2], id: result).first
      if not pre.nil?
        @results2 << pre
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
    @resultados = params[:results]
    @results = []
    @selecao = params[:selecao]
    @resultados.each do |result|
      pre = Result.where(data_final: params[:data_final], id: result).first
      if not pre.nil?
        @results << pre
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


    respond_to do |format|
    format.js {}
    end
  end

  def list

    if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id]).all
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
          @users << User.where(course_id: course.ids)
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
          @users << User.where(course_id: course.ids)
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
      @users = User.where(course_id: params[:course_id], type: 'Student').find_each
      @users = @users.to_a
      @course = Course.where(id: params[:course_id]).first
      @selecao = @course.nome
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
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
        @users << user
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end

      @results = []
      @users.each do |user|
          user.results.each do |result|
            @results << result
          end
      end

    @datas = @results.map(&:data_final).uniq

  end

  def search

  end

  def analytics

  end

  def analytic_list

     if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id]).all
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
          @users << User.where(course_id: course.ids)
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
          @users << User.where(course_id: course.ids)
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
      @users = User.where(course_id: params[:course_id], type: 'Student').find_each
      @users = @users.to_a
      @course = Course.where(id: params[:course_id]).first
      @selecao = @course.nome
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
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
        @users << user
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end

      @results = []
      @users.each do |user|
          user.results.each do |result|
            @results << result
          end
      end

    @datas = @results.map(&:data_final).uniq


    #selecao2

    if params[:institution2_id] == 'todos'
      @users2 = User.where(type: 'Student').find_each
      @selecao2 = "todos os institutos"
    else
      @users2 = User.where(institution_id: params[:institution2_id]).all
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
          @users2 << User.where(course_id: course.ids)
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
          @users2 << User.where(course_id: course.ids)
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
          @users2 << User.where(course_id: course.id,  type: 'Student')
      end
      @users2 = @users2.first.to_a
    end

    if params[:course2_id] != 'todos' && params[:center2_id] != nil && params[:center2_id] != 'todos'
      @users2 = User.where(course_id: params[:course2_id], type: 'Student').find_each
      @users2 = @users2.to_a
      @course2 = Course.where(id: params[:course2_id]).first
      @selecao2 = @course2.nome
    end

    if params[:subject2_id] != 'todos' && params[:subject2_id] != nil
      @classrooms2 = Classroom.where(subject_id: params[:subject2_id]).find_each
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          @users2 << user
        end
      end
      @subject2 = Subject.where(id: params[:subject2_id]).first
      @selecao2 = @subject2.nome
    end

    if params[:classroom2_id] != 'todos' && params[:classroom2_id] != nil
      @classroom2 = Classroom.where(id: params[:classroom2_id]).first
      @selecao2 = "turma " + @classroom2.codigo
      @users2 = []
      @classroom2.users.each do |user|
        @users2 << user
      end
    end

    if params[:users2_id] != 'todos' && params[:users2_id] != nil
      @user2 = User.where(id: params[:users2_id]).first
      @users2 = []
      @users2 << @user2
      @selecao2 = @users2.first.nome
    end

      @results2 = []
      @users2.each do |user|
          user.results.each do |result|
            @results2 << result
          end
      end

    @datas2 = @results2.map(&:data_final).uniq
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
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
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
