class AdminController < ApplicationController
  before_action :admin_check
  skip_before_action :authenticate_user!

  def admin_check
    if current_user.type != "Administrator"
      redirect_to welcome_index_path
    end
  end

  def index
    @pendings_students = User.where(type: 'Student', approved: false).find_each
    @pendings = User.where(approved: false).find_each
  end

  def search
    @users = User.order(:nome).where("nome ilike ?", "%#{params[:term]}%")
    render json: @users.map{|user| {:label => user.nome, :value => user.id}}
  end

  def aprove
    @pending = User.where(id: params[:pending]).first
    @pending.approved = true
    @pending.save
    @learning_quizzes = LearningQuiz.all.sort_by &:created_at
    @learning_quiz = @learning_quizzes.last
    @learning_quiz.users << @pending
    @quizzes = Quiz.all.sort_by &:created_at
    @quiz = @quizzes.last
    @quiz.users << @pending
    flash[:notice] = 'usuario aprovado'
    redirect_to admin_index_path
  end

  def admin_params
      params.permit(:pending)
  end

end