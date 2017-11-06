class AnswerCasesController < ApplicationController
  before_action :set_answer_case, only: [:show, :edit, :update, :destroy]

  # GET /answer_cases
  # GET /answer_cases.json
  def index
    @answer_cases = AnswerCase.all
  end

  # GET /answer_cases/1
  # GET /answer_cases/1.json
  def show
  end

  # GET /answer_cases/new
  def new
    @answer_case = AnswerCase.new
  end

  # GET /answer_cases/1/edit
  def edit
  end

  # POST /answer_cases
  # POST /answer_cases.json
  def create
    @answer_case = AnswerCase.new(answer_case_params)
    question = Question.find(@answer_case.question_id)
    line_case = LineCase.find(question.line_case_id)
    respond_to do |format|
      if @answer_case.save
        format.html { redirect_to line_case_path(line_case), notice: 'A Resposta Foi Cadastrada Com Sucesso.' }
        format.json { render :show, status: :created, location: @answer_case }
      else
        format.html { render :new }
        format.json { render json: @answer_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answer_cases/1
  # PATCH/PUT /answer_cases/1.json
  def update
    respond_to do |format|
      if @answer_case.update(answer_case_params)
        format.html { redirect_to @answer_case, notice: 'Answer case was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer_case }
      else
        format.html { render :edit }
        format.json { render json: @answer_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_cases/1
  # DELETE /answer_cases/1.json
  def destroy
    question = Question.find(@answer_case.question_id)
    line_case = LineCase.find(question.line_case_id)
    notes = @answer_case.note_cases
    if notes.length > 0
        redirect_to line_case_path(line_case), alert: 'Não é possível excluir respostas corrigidas.' 
    else
      @answer_case.destroy
      respond_to do |format|
        format.html { redirect_to line_case_path(line_case), notice: 'Resposta excluída com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_case
      @answer_case = AnswerCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_case_params
      params.require(:answer_case).permit(:resposta, :user_id, :question_id)
    end
end
