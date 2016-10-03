class StudyCasesController < ApplicationController
  before_action :set_study_case, only: [:show, :edit, :update, :destroy]
  autocomplete :study_case, :title, :full => true

  def check_privilege(study_case)
     unless current_user.id == study_case.user_id
      redirect_to welcome_index_path
      return
    end
  end
  # GET /study_cases
  # GET /study_cases.json
  def index
    @study_cases = StudyCase.all
  end

  # GET /study_cases/1
  # GET /study_cases/1.json
  def show
    check_privilege(@study_case)
    @questions = @study_case.questions
  end

  # GET /study_cases/new
  def new
    @study_case = StudyCase.new
  end

  # GET /study_cases/1/edit
  def edit
    check_privilege(@study_case)
  end

  def search

  end

  def list
    @study_cases = StudyCase.where("title ilike ?", params[:title])
  end

  # POST /study_cases
  # POST /study_cases.json
  def create
    @study_case = StudyCase.new(study_case_params)
    @study_case.user = current_user
    @study_case.recommended = params[:recommended].to_sentence
    if params[:relat]
      if params[:relat][:atu] == 'yes'
        @reference = Reference.new
        @reference.text = params[:reference]
        @reference.study_case = @study_case
        @reference.save
      end
    end
    respond_to do |format|
      if @study_case.save
        format.html { redirect_to @study_case, notice: 'Study case was successfully created.' }
        format.json { render :show, status: :created, location: @study_case }
      else
        format.html { render :new }
        format.json { render json: @study_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_cases/1
  # PATCH/PUT /study_cases/1.json
  def update
    respond_to do |format|
      if @study_case.update(study_case_params)
        format.html { redirect_to @study_case, notice: 'Study case was successfully updated.' }
        format.json { render :show, status: :ok, location: @study_case }
      else
        format.html { render :edit }
        format.json { render json: @study_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_cases/1
  # DELETE /study_cases/1.json
  def destroy
    check_privilege(@study_case)
    @study_case.destroy
    respond_to do |format|
      format.html { redirect_to study_cases_url, notice: 'Study case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_case
      @study_case = StudyCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_case_params
      params.require(:study_case).permit(:title, :author, :area, :topic, :topic2, :recommended, :abstract, :case_file, :notes_file)
    end
end
