class PurposesController < ApplicationController
  before_action :set_purpose, only: [:edit, :update, :destroy]
 skip_before_action :verify_authenticity_token

  def edit
  end

  def create
    @purpose = Purpose.new(purpose_params)

    respond_to do |format|
      if @purpose.save
        format.js 
      end
    end
  end

  # PATCH/PUT /purposes/1
  def update
    respond_to do |format|
      if @purpose.update(purpose_params)
        format.html { redirect_to student_area_edit_curriculo_path  , notice: 'Área do conhecimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @purpose }
      else
        format.html { render :edit }
        format.json { render json: @purpose.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purposes/1
  # DELETE /purposes/1.json
  def destroy
    @purpose.destroy
    respond_to do |format|
      format.html { redirect_to purposes_url, notice: 'purpose was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_purpose
      @purpose = Purpose.find(params[:id])
    end

    def purpose_params
      params.require(:purpose).permit(:description,:curriculum_id)
    end
end
