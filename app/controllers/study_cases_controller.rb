class StudyCasesController < ApplicationController
  before_action :set_study_case, only: [:show, :edit, :update, :destroy]

  # GET /study_cases
  # GET /study_cases.json
  def index
    @study_cases = StudyCase.all
  end

  # GET /study_cases/1
  # GET /study_cases/1.json
  def show
  end

  # GET /study_cases/new
  def new
    @study_case = StudyCase.new
  end

  # GET /study_cases/1/edit
  def edit
  end

  # POST /study_cases
  # POST /study_cases.json
  def create
    @study_case = StudyCase.new(study_case_params)

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
      params.require(:study_case).permit(:title, :author, :area, :topic, :topic2, :recommended, :abstract)
    end
end
