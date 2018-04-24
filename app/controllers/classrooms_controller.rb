class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  autocomplete :user, :nome, :full => true
  # GET /classrooms
  # GET /classrooms.json
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
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @subjects = @subjects.sort_by{ |subject| subject.nome}
    @students = @students.uniq { |s| s.nome}
    @students = @students.sort_by{ |student| student.nome}

  end

  def setup_coordinator_search
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


  def setup_principal_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @subjects = []
    @classrooms = []
    @students = []
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
    @students = @students.uniq { |s| s.nome}
  end

  def index
    if current_user.type == 'Administrator'
      @classrooms = Classroom.all
    elsif current_user.type == 'Principal'
      setup_principal_search
    elsif current_user.type == 'Coordinator'
      setup_coordinator_search
    elsif current_user.type == 'Teacher'
      setup_teacher_search
    end
  end

  def search
    if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).find_each
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end

  def add_user
    @user = User.where(nome: params[:user_id]).first
    @classroom = Classroom.find(params[:classroom_id])
    if @user.nil?
      redirect_to @classroom, alert: "Não foi possível encontrar o usuário na base de dados."
    elsif @user.type == 'Student'
      @student = Student.where(nome: params[:user_id]).first
      @classroom.students << @user
      redirect_to @classroom, notice:  "#{@user.nome} foi adicionado(a)."

    elsif @user.type == 'Teacher'
      @classroom.teachers << @user
      redirect_to @classroom, notice:  "#{@user.nome} adicionado(a)."

    end

  end

  def remove_user
   @user = User.find(params[:user])
   @classroom = Classroom.find(params[:classroom])
   @classroom.users.delete(@user)
   if @user.type == 'Student'
    @classroom.students.delete(@user)
   end
    redirect_to  @classroom, alert: "O Usuário #{@user.nome} foi removido"
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @users = User.all
    @students = @classroom.students
    @students = @students.sort_by{ |student| student.nome}
    @teachers = @classroom.teachers
  end

  def list
    if params[:institution_id] == 'todos'
      @classrooms = Classroom.all
      @selecao = "todos os institutos"
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'

      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
      @courses = []
      @centers = []
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @subjects = []
      @classrooms = []
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

    end

    if params[:center_id] == 'todos' && params[:campu_id] != 'todos'
      @centers = Center.where(campu_id: params[:campu_id]).find_each
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @courses = []
      @subjects = []
      @classrooms = []
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


    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @center = Center.where(campu_id: params[:campu_id]).first
      @selecao = @center.name
      @courses = Course.where(center_id: params[:center_id]).find_each
      @subjects = []
      @classrooms = []
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
    end

    if params[:course_id] != 'todos' && params[:center_id] != nil && params[:center_id] != 'todos'
      @course = Course.where(id: params[:course_id]).first
      @selecao = @course.nome
      @subjects = @course.subjects
      @classrooms = []
      @subjects.each do |subject|
      pre = Classroom.where(subject: subject).load
       pre.each do |p|
        if not p.nil?
          @classrooms << p
        end
      end
    end

    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @subject = Subject.where(id: params[:subject_id]).first
      @selecao = @subject.nome
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classrooms = []
      @classroom = Classroom.find(params[:classroom_id])
      @selecao = "turma " + @classroom.codigo
      @classrooms << @classroom
    end
    if current_user.type == 'Teacher'
      if params[:subject_id] != 'todos'
        @classrooms = current_user.classrooms.where(subject_id: params[:subject_id])
      else
         @classrooms = current_user.classrooms
      end
    end

  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
   if current_user.type == 'Principal'
      setup_principal_search
    elsif current_user.type == 'Coordinator'
      setup_coordinator_search
    elsif current_user.type == 'Teacher'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).find_each
    end
  end

  # GET /classrooms/1/edit
  def edit
    if current_user.type == 'Principal'
      setup_principal_search
    elsif current_user.type == 'Coordinator'
      setup_coordinator_search
    elsif current_user.type == 'Teacher'
      setup_teacher_search
    end
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    # eu alterei e é importante para verificar erros


      @classroom = Classroom.new(classroom_params)
      if current_user.type == 'Teacher'
        @classroom.teachers << current_user
      end

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'A turma foi cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Turma atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'Turma deletada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:subject_id, :turno, :codigo, :user_id, :classroom_id, :ano, :semestre)
    end
end
