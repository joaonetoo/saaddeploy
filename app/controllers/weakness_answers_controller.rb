class WeaknessAnswersController < ApplicationController
  before_action :set_weakness_answer, only: [:show, :edit, :update, :destroy]

  # GET /weakness_answers
  # GET /weakness_answers.json
  def index
    @weakness_answers = WeaknessAnswer.all
  end

  # GET /weakness_answers/1
  # GET /weakness_answers/1.json
  def show
  end

  # GET /weakness_answers/new
  def new
    @weakness_answer = WeaknessAnswer.new
  end

  # GET /weakness_answers/1/edit
  def edit
  end

  # POST /weakness_answers
  # POST /weakness_answers.json
  def create
    @weakness_answer = WeaknessAnswer.new(weakness_answer_params)

    respond_to do |format|
      if @weakness_answer.save
        format.html { redirect_to @weakness_answer, notice: 'Weakness answer was successfully created.' }
        format.json { render :show, status: :created, location: @weakness_answer }
      else
        format.html { render :new }
        format.json { render json: @weakness_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weakness_answers/1
  # PATCH/PUT /weakness_answers/1.json
  def update
    respond_to do |format|
      if @weakness_answer.update(weakness_answer_params)
        format.html { redirect_to @weakness_answer, notice: 'Weakness answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @weakness_answer }
      else
        format.html { render :edit }
        format.json { render json: @weakness_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weakness_answers/1
  # DELETE /weakness_answers/1.json
  def destroy
    @weakness_answer.destroy
    respond_to do |format|
      format.html { redirect_to weakness_answers_url, notice: 'Weakness answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weakness_answer
      @weakness_answer = WeaknessAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weakness_answer_params
      params.require(:weakness_answer).permit(:text, :weakness_id)
    end
end
