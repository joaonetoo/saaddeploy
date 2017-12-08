class PurposesController < ApplicationController
  before_action :set_purpose, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def edit
    respond_to do |format|
      format.js 
    end
  end

  def create
    @purpose = Purpose.new(purpose_params)
    @purposes = Purpose.where(curriculum_id: @purpose.curriculum_id)
    respond_to do |format|
      if @purpose.save
        format.js 
      end
    end
  end

  # PATCH/PUT /purposes/1
  def update
    @purpose.description = params[:description]
    @purpose.save
    respond_to do |format|
        format.js
      end
  end

  # DELETE /purposes/1
  # DELETE /purposes/1.json
  def destroy
    @purpose.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_purpose
      @purpose = Purpose.find(params[:id])
      @purposes = Purpose.where(curriculum_id: @purpose.curriculum_id)
    end

    def purpose_params
      params.require(:purpose).permit(:description,:curriculum_id)
    end
end
