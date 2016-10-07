class LearningQuizzesController < ApplicationController
  before_action :set_learning_quiz, only: [:show, :edit, :update, :destroy]

  # GET /learning_quizzes
  # GET /learning_quizzes.json
  def index
    @learning_quizzes = LearningQuiz.all
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
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}

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

  # GET /learning_quizzes/1
  # GET /learning_quizzes/1.json
  def show
  end

  # GET /learning_quizzes/new
  def new
    @learning_quiz = LearningQuiz.new
    if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).find_each
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end

  # GET /learning_quizzes/1/edit
  def edit
  end

  # POST /learning_quizzes
  # POST /learning_quizzes.json
  def create
    @learning_quiz = LearningQuiz.new(learning_quiz_params)
    @learning_quiz.creator_id = current_user.id

    if params[:institution_id] == 'todos'
      @users = User.all
    else
      @users = User.where(institution_id: params[:institution_id]).all
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
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
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
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
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids)
      end
    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.id)
      end
    end

    if params[:course_id] == 'todos' && params[:center_id] != 'todos'
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.id)
      end
    elsif params[:course_id] != 'todos' && params[:center_id] != nil
      @users = User.where(course_id: params[:course_id]).find_each
    end

    if params[:subject_id] == 'todos' && params[:course_id] != 'todos'
      @users = User.where(course_id: params[:course_id]).find_each
    elsif params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
        end
      end
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @users = []
      @classroom.users.each do |user|
        @users << user
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
    end

    @users.each do |user|
        @learning_quiz.users << user
    end

    respond_to do |format|
      if @learning_quiz.save
        format.html { redirect_to welcome_index_path, notice: 'Questionario criado' }
        format.json { render :show, status: :created, location: @learning_quiz }
      else
        format.html { render :new }
        format.json { render json: @learning_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learning_quizzes/1
  # PATCH/PUT /learning_quizzes/1.json
  def update
    respond_to do |format|
      if @learning_quiz.update(learning_quiz_params)
        format.html { redirect_to @learning_quiz, notice: 'Learning quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @learning_quiz }
      else
        format.html { render :edit }
        format.json { render json: @learning_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_quizzes/1
  # DELETE /learning_quizzes/1.json
  def destroy
    @learning_quiz.destroy
    respond_to do |format|
      format.html { redirect_to learning_quizzes_url, notice: 'Learning quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_quiz
      @learning_quiz = LearningQuiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def learning_quiz_params
      params.require(:learning_quiz).permit(:user_id, :data_final)
    end
end
