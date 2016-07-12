class LearningResultsController < ApplicationController
  before_action :set_learning_result, only: [:show, :edit, :update, :destroy]

  # GET /learning_results
  # GET /learning_results.json
  def index
    @learning_results = LearningResult.all
  end

  # GET /learning_results/1
  # GET /learning_results/1.json
  def show
  end

  # GET /learning_results/new
  def new
    @learning_result = LearningResult.new
  end

  # GET /learning_results/1/edit
  def edit
  end

  # POST /learning_results
  # POST /learning_results.json
  def create
    @learning_result = LearningResult.new(learning_result_params)

    respond_to do |format|
      if @learning_result.save
        format.html { redirect_to @learning_result, notice: 'Learning result was successfully created.' }
        format.json { render :show, status: :created, location: @learning_result }
      else
        format.html { render :new }
        format.json { render json: @learning_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learning_results/1
  # PATCH/PUT /learning_results/1.json
  def update
    respond_to do |format|
      if @learning_result.update(learning_result_params)
        format.html { redirect_to @learning_result, notice: 'Learning result was successfully updated.' }
        format.json { render :show, status: :ok, location: @learning_result }
      else
        format.html { render :edit }
        format.json { render json: @learning_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_results/1
  # DELETE /learning_results/1.json
  def destroy
    @learning_result.destroy
    respond_to do |format|
      format.html { redirect_to learning_results_url, notice: 'Learning result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_result
      @learning_result = LearningResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def learning_result_params
      params.require(:learning_result).permit(:ec, :or, :ca, :ea, :student_id, :user_id, :data_final)
    end
end
