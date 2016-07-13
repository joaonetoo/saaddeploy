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
    @data_final = params[:data_final]
  end

  # GET /learning_results/1/edit
  def edit
  end

  # POST /learning_results
  # POST /learning_results.json
  def create
    @learning_result = LearningResult.new(learning_result_params)
    @learning_result.ec = params[:q1a].to_i + params[:q2c].to_i + params[:q3d].to_i + params[:q4a].to_i + params[:q5a].to_i + params[:q6c].to_i + params[:q7b].to_i + params[:q8d].to_i + params[:q9b].to_i + params[:q10b].to_i + params[:q11a].to_i + params[:q12b].to_i
    @learning_result.or = params[:q1d].to_i + params[:q2a].to_i + params[:q3c].to_i + params[:q4c].to_i + params[:q5b].to_i + params[:q6a].to_i + params[:q7a].to_i + params[:q8c].to_i + params[:q9a].to_i + params[:q10a].to_i + params[:q11b].to_i + params[:q12c].to_i
    @learning_result.ca = params[:q1b].to_i + params[:q2b].to_i + params[:q3a].to_i + params[:q4d].to_i + params[:q5c].to_i + params[:q6d].to_i+ params[:q7c].to_i + params[:q8b].to_i + params[:q9d].to_i + params[:q10d].to_i + params[:q11c].to_i + params[:q12a].to_i
    @learning_result.ea = params[:q1c].to_i + params[:q2d].to_i + params[:q3b].to_i + params[:q4b].to_i + params[:q5d].to_i + params[:q6b].to_i + params[:q7d].to_i + params[:q8a].to_i + params[:q9c].to_i + params[:q10c].to_i + params[:q11d].to_i + params[:q12d].to_i
    @learning_result.user_id = current_user.id
    @learning_result.student_id = current_user.id
    debugger
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
