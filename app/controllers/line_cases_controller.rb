class LineCasesController < ApplicationController
  before_action :set_line_case, only: [:show, :edit, :update, :destroy]

  # GET /line_cases
  # GET /line_cases.json
  def index
    @line_cases = LineCase.all
  end

  # GET /line_cases/1
  # GET /line_cases/1.json
  def show
  end

  # GET /line_cases/new
  def new
    @line_case = LineCase.new
  end

  # GET /line_cases/1/edit
  def edit
  end

  # POST /line_cases
  # POST /line_cases.json
  def create
    @line_case = LineCase.new(line_case_params)

    respond_to do |format|
      if @line_case.save
        format.html { redirect_to @line_case, notice: 'Line case was successfully created.' }
        format.json { render :show, status: :created, location: @line_case }
      else
        format.html { render :new }
        format.json { render json: @line_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_cases/1
  # PATCH/PUT /line_cases/1.json
  def update
    respond_to do |format|
      if @line_case.update(line_case_params)
        format.html { redirect_to @line_case, notice: 'Line case was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_case }
      else
        format.html { render :edit }
        format.json { render json: @line_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_cases/1
  # DELETE /line_cases/1.json
  def destroy
    @line_case.destroy
    respond_to do |format|
      format.html { redirect_to line_cases_url, notice: 'Line case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_case
      @line_case = LineCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_case_params
      params.require(:line_case).permit(:study_case_id, :user_id, :data_final, :question_id)
    end
end
