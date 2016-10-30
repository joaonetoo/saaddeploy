class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  autocomplete :subject, :nome, :full => true

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
    if current_user.type == 'Administrator'
      @courses = Course.all
    elsif current_user.type == 'Principal'
      @subjects = current_user.search_subjects
    end

  end

  def search
      @subjects = Subject.order(:nome).where("nome ilike ?", "%#{params[:term]}%")
      render json: @subjects.map{|subject| {:label => subject.nome, :value => subject.id}}
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
    @course = Course.all
    if current_user.type == 'Principal'
      @courses = current_user.courses
    end
  end

  # GET /subjects/1/edit
  def edit
    if current_user.type == 'Principal'
      current_user.setup_search
    end
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:nome, :ch, :ementa, :codigo, :course_id)
    end
end
