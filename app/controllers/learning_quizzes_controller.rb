class LearningQuizzesController < ApplicationController
  before_action :set_learning_quiz, only: [:show, :edit, :update, :destroy]

  # GET /learning_quizzes
  # GET /learning_quizzes.json
  def index
    @learning_quizzes = LearningQuiz.all
  end

  # GET /learning_quizzes/1
  # GET /learning_quizzes/1.json
  def show
  end

  # GET /learning_quizzes/new
  def new
    @learning_quiz = LearningQuiz.new
    @students = User.where(type: "Student").to_a
    @users = []
    @students.each do |student|
        @users << student.id
    end
  end

  # GET /learning_quizzes/1/edit
  def edit
  end

  # POST /learning_quizzes
  # POST /learning_quizzes.json
  def create
    @learning_quiz = LearningQuiz.new(learning_quiz_params)

    respond_to do |format|
      if @learning_quiz.save
        format.html { redirect_to @learning_quiz, notice: 'Learning quiz was successfully created.' }
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
