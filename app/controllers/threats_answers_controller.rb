class ThreatsAnswersController < ApplicationController
  before_action :set_threats_answer, only: [:show, :edit, :update, :destroy]

  # GET /threats_answers
  # GET /threats_answers.json
  def index
    @threats_answers = ThreatsAnswer.all
  end

  # GET /threats_answers/1
  # GET /threats_answers/1.json
  def show
  end

  # GET /threats_answers/new
  def new
    @threats_answer = ThreatsAnswer.new
  end

  # GET /threats_answers/1/edit
  def edit
  end

  # POST /threats_answers
  # POST /threats_answers.json
  def create
    @threats_answer = ThreatsAnswer.new(threats_answer_params)

    respond_to do |format|
      if @threats_answer.save
        format.html { redirect_to @threats_answer, notice: 'Threats answer was successfully created.' }
        format.json { render :show, status: :created, location: @threats_answer }
      else
        format.html { render :new }
        format.json { render json: @threats_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /threats_answers/1
  # PATCH/PUT /threats_answers/1.json
  def update
    respond_to do |format|
      if @threats_answer.update(threats_answer_params)
        format.html { redirect_to @threats_answer, notice: 'Threats answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @threats_answer }
      else
        format.html { render :edit }
        format.json { render json: @threats_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /threats_answers/1
  # DELETE /threats_answers/1.json
  def destroy
    @threats_answer.destroy
    respond_to do |format|
      format.html { redirect_to threats_answers_url, notice: 'Threats answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_threats_answer
      @threats_answer = ThreatsAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def threats_answer_params
      params.require(:threats_answer).permit(:text, :threat_id)
    end
end
