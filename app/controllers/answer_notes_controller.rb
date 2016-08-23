class AnswerNotesController < ApplicationController
  before_action :set_answer_note, only: [:show, :edit, :update, :destroy]

  # GET /answer_notes
  # GET /answer_notes.json
  def index
    @answer_notes = AnswerNote.all
  end

  # GET /answer_notes/1
  # GET /answer_notes/1.json
  def show
  end

  # GET /answer_notes/new
  def new
    @answer_note = AnswerNote.new
    @answer = params[:answer]
  end

  # GET /answer_notes/1/edit
  def edit
  end

  # POST /answer_notes
  # POST /answer_notes.json
  def create
    @answer_note = AnswerNote.new(answer_note_params)
    @answer_note.user = current_user
    respond_to do |format|
      if @answer_note.save
        format.html { redirect_to teachers_area_list_atividades_path, notice: 'Correção feita.' }
        format.json { render :show, status: :created, location: @answer_note }
      else
        format.html { render :new }
        format.json { render json: @answer_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answer_notes/1
  # PATCH/PUT /answer_notes/1.json
  def update
    respond_to do |format|
      if @answer_note.update(answer_note_params)
        format.html { redirect_to @answer_note, notice: 'Answer note was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer_note }
      else
        format.html { render :edit }
        format.json { render json: @answer_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_notes/1
  # DELETE /answer_notes/1.json
  def destroy
    @answer_note.destroy
    respond_to do |format|
      format.html { redirect_to answer_notes_url, notice: 'Answer note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_note
      @answer_note = AnswerNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_note_params
      params.require(:answer_note).permit(:observacao, :answer_id, :user_id, :arquivo)
    end
end
