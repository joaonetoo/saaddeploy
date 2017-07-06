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
    @learning_quiz = LearningQuiz.new
    @learning_quiz.data_final = DateTime.now.to_date
    @learning_quiz.users << @pending
    @learning_quiz.save
    @quiz = Quiz.new
    @quiz.data_final = DateTime.now.to_date
    @quiz.users << @pending
    @quiz.save
    flash[:notice] = 'usuario aprovado'
    redirect_to admin_index_path

  end

  def admin_params
      params.permit(:pending)
  end

end