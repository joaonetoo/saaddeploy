class StrengthAnswersController < ApplicationController
  before_action :set_strength_answer, only: [:show, :edit, :update, :destroy]

  # GET /strength_answers
  # GET /strength_answers.json
  def index
    @strength_answers = StrengthAnswer.all
  end

  # GET /strength_answers/1
  # GET /strength_answers/1.json
  def show
  end

  # GET /strength_answers/new
  def new
    @strength_answer = StrengthAnswer.new
  end

  # GET /strength_answers/1/edit
  def edit
  end

  # POST /strength_answers
  # POST /strength_answers.json
  def create
    @strength_answer = StrengthAnswer.new(strength_answer_params)
    @strength = Strength.find(@strength_answer.strength)
    @plano = current_user.plano
    @strengths = @plano.strengths
    respond_to do |format|
      if @strength_answer.save
        format.html { redirect_to @strength_answer, notice: 'Strength answer was successfully created.' }
        format.json { render :show, status: :created, location: @strength_answer }
        format.js
      else
        format.html { render :new }
        format.json { render json: @strength_answer.errors, status: :unprocessable_entity }
        format.js   { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /strength_answers/1
  # PATCH/PUT /strength_answers/1.json
  def update
    respond_to do |format|
      if @strength_answer.update(strength_answer_params)
        format.html { redirect_to @strength_answer, notice: 'Strength answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @strength_answer }
      else
        format.html { render :edit }
        format.json { render json: @strength_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /strength_answers/1
  # DELETE /strength_answers/1.json
  def destroy
    @strength_answer.destroy
    @plano = current_user.plano
    @strengths = @plano.strengths
    respond_to do |format|
      format.html { redirect_to strength_answers_url, notice: 'Strength answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_strength_answer
      @strength_answer = StrengthAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def strength_answer_params
      params.require(:strength_answer).permit(:text, :strength_id)
    end
end
