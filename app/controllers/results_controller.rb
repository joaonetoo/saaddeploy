class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
require 'set'
  # GET /results
  # GET /results.json
  def index
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  def show_by_date
    @results = Result.where(data_final: params[:data_final]).find_each.to_a
    @mediaTf = 0.0
    @mediaGm = 0.0
    @mediaAu = 0.0
    @mediaSe = 0.0
    @mediaEc = 0.0
    @mediaSv = 0.0
    @mediaCh = 0.0
    @mediaLs = 0.0
    @results.each do |result|
      @mediaTf = @mediaTf + result.tf
      @mediaGm = @mediaGm + result.gm
      @mediaAu = @mediaAu + result.au
      @mediaSe = @mediaSe + result.se
      @mediaEc = @mediaEc + result.ec
      @mediaSv = @mediaSv + result.sv
      @mediaCh = @mediaCh + result.ch
      @mediaLs = @mediaLs + result.ls
    end
    @mediaTf = @mediaTf / @results.size.to_f
    @mediaGm = @mediaGm / @results.size.to_f
    @mediaAu = @mediaAu / @results.size.to_f
    @mediaSe = @mediaSe / @results.size.to_f
    @mediaEc = @mediaEc / @results.size.to_f
    @mediaSv = @mediaSv / @results.size.to_f
    @mediaCh = @mediaCh / @results.size.to_f
    @mediaLs = @mediaLs / @results.size.to_f


    respond_to do |format|
    format.js {}
    end
  end

  def list

     if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
    else
      @users = User.where(institution_id: params[:institution_id]).all
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @centers = []
      @campus.each do |campus|
          @centers << Center.where(campu_id: campus.id)
      end
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.ids)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids)
      end
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
      @centers = @campus.centers.all
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids)
      end
    end

    if params[:center_id] == 'todos' && params[:campu_id] != 'todos'
      @centers = Center.where(campu_id: params[:campu_id]).find_each
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids)
      end
    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.id)
      end
    end

    if params[:course_id] == 'todos' && params[:center_id] != 'todos'
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.id)
      end
    elsif params[:course_id] != 'todos' && params[:center_id] != nil
      @users = User.where(course_id: params[:course_id]).find_each
    end

    if params[:subject_id] == 'todos' && params[:course_id] != 'todos'
      @users = User.where(course_id: params[:course_id]).find_each
    elsif params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
        end
      end
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @users = []
      @classroom.users.each do |user|
        @users << user
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
    end

      @results = []
      @users.each do |user|
          user.results.each do |result|
            @results << result
          end
      end

    @datas = []
    @datas << @results.first
    @results.each do |element|
      @datas.each do |data|
        if data.data_final == element.data_final
        # duplicated item
        else
        # first appearance
          @datas << element
        end
      end
    end

  end

  def search

  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:data_final, :tf, :gm, :au, :se, :ec, :sv, :ch, :ls, :user_id, :quiz_id, :final_date)
    end
end
