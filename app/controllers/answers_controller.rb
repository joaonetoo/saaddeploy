class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    @atividade_extra = params[:atividade_extra]
    @atividade = AtividadeExtra.where(id: params[:atividade_extra])
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.status = "respondido"
    if @answer.arquivo_resposta_content_type != "application/pdf" && @answer.arquivo_resposta_content_type != "application/vnd.openxmlformats-officedocument.wordprocessingml.document" && @answer.arquivo_resposta_content_type != "application/msword" 
      @answer.destroy
      redirect_to student_area_list_atividades_path , alert: 'Não foi possivel enviar sua resposta, insira um arquivo do tipo pdf ou word.' 
    else
      respond_to do |format|
        if @answer.save
          format.html { redirect_to admin_index_path, notice: 'Sua resposta foi enviada com sucesso.' }
          format.json { render :show, status: :created, location: @answer }
        else
          format.html { render :new }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:observacao, :atividade_extra_id, :arquivo_resposta)
    end
end
