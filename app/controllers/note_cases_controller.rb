class NoteCasesController < ApplicationController
  before_action :set_note_case, only: [:show, :edit, :update, :destroy]

  # GET /note_cases
  # GET /note_cases.json
  def index
    @note_cases = NoteCase.all
  end

  # GET /note_cases/1
  # GET /note_cases/1.json
  def show
  end

  # GET /note_cases/new
  def new
    @note_case = NoteCase.new
  end

  # GET /note_cases/1/edit
  def edit
  end

  # POST /note_cases
  # POST /note_cases.json
  def create
    @note_case = NoteCase.new(note_case_params)
    answer_case = AnswerCase.find(@note_case.answer_case_id)
    question = Question.find(answer_case.question_id)
    line_case = question.line_case_id
    user_id = answer_case.user_id
    respond_to do |format|
      if @note_case.save
        format.html { redirect_to teachers_area_case_questions_path(line_case: line_case,user_id: user_id), notice: 'Correção enviada com sucesso.' }
        format.json { render :show, status: :created, location: @note_case }
      else
        format.html { render :new }
        format.json { render json: @note_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_cases/1
  # PATCH/PUT /note_cases/1.json
  def update
    respond_to do |format|
      if @note_case.update(note_case_params)
        format.html { redirect_to @note_case, notice: 'Note case was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_case }
      else
        format.html { render :edit }
        format.json { render json: @note_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_cases/1
  # DELETE /note_cases/1.json
  def destroy
    @note_case.destroy
    respond_to do |format|
      format.html { redirect_to note_cases_url, notice: 'Note case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_case
      @note_case = NoteCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_case_params
      params.require(:note_case).permit(:observacao, :user_id, :answer_case_id)
    end
end
