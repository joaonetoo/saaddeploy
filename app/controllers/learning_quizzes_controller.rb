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
    #@learning_quiz.creator_id = current_user.id
    @users = User.all
    @learning_quiz.data_final = DateTime.now.to_date
    @users.each do |user|
        @equal = false
        @user_learning_quizzes = user.learning_quizzes
        if @user_learning_quizzes.size > 0
          @user_learning_quizzes.each do |user_learning_quiz|
          if user_learning_quiz.data_final == @learning_quiz.data_final
            @equal = true
          end
        end
        if @equal == false && user.approved == true
          @learning_quiz.users << user
        end
      elsif user.approved == true
        @learning_quiz.users << user
    end
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
