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

  def search
  end

  def analytics
  end

   def compare_by_date
      @selecao = params[:selecao]
      @resultados = params[:results]
      @learning_results = []
      @resultados.each do |result|
        pre = LearningResult.where(data_final: params[:data_final], id: result).first
        if not pre.nil?
          @learning_results << pre
        end
      end
      @mediaEc = 0
      @mediaOr = 0
      @mediaCa = 0
      @mediaEa = 0

      @mediaDi = 0
      @mediaAc = 0
      @mediaAs = 0
      @mediaCo = 0
      @learning_results.each do |result|
        @mediaEc = @mediaEc + result.ec
        @mediaOr = @mediaOr + result.or
        @mediaCa = @mediaCa + result.ca
        @mediaEa = @mediaEa + result.ea
        @mediaDi = @mediaDi + ((result.ec + result.or) / 2)
        @mediaAc = @mediaAc + ((result.ec + result.ea) / 2)
        @mediaAs = @mediaAs + ((result.or + result.ca) / 2)
        @mediaCo = @mediaCo + ((result.ea + result.ca) / 2)
      end
      @mediaEc = (@mediaEc / @learning_results.size.to_f) / 0.48
      @mediaOr = @mediaOr / @learning_results.size.to_f / 0.48
      @mediaCa = @mediaCa / @learning_results.size.to_f / 0.48
      @mediaEa = @mediaEa / @learning_results.size.to_f / 0.48

      @mediaDi = @mediaDi / @learning_results.size.to_f / 0.48
      @mediaAc = @mediaAc / @learning_results.size.to_f / 0.48
      @mediaAs = @mediaAs / @learning_results.size.to_f / 0.48
      @mediaCo = @mediaCo / @learning_results.size.to_f / 0.48
      #selecao 2

      @selecao2 = params[:selecao2]
      @resultados2 = params[:results2]
      @learning_results2 = []
      @resultados2.each do |result|
        pre = LearningResult.where(data_final: params[:data_final2], id: result).first
        if not pre.nil?
          @learning_results2 << pre
        end
      end
      @mediaEc2 = 0
      @mediaOr2 = 0
      @mediaCa2 = 0
      @mediaEa2 = 0

      @mediaDi2 = 0
      @mediaAc2 = 0
      @mediaAs2 = 0
      @mediaCo2 = 0
      @learning_results2.each do |result|
        @mediaEc2 = @mediaEc2 + result.ec
        @mediaOr2 = @mediaOr2 + result.or
        @mediaCa2 = @mediaCa2 + result.ca
        @mediaEa2 = @mediaEa2 + result.ea
        @mediaDi2 = @mediaDi2 + ((result.ec + result.or) / 2)
        @mediaAc2 = @mediaAc2 + ((result.ec + result.ea) / 2)
        @mediaAs2 = @mediaAs2 + ((result.or + result.ca) / 2)
        @mediaCo2 = @mediaCo2 + ((result.ea + result.ca) / 2)
      end
      @mediaEc2 = (@mediaEc2 / @learning_results2.size.to_f) / 0.48
      @mediaOr2 = @mediaOr2 / @learning_results2.size.to_f / 0.48
      @mediaCa2 = @mediaCa2 / @learning_results2.size.to_f / 0.48
      @mediaEa2 = @mediaEa2 / @learning_results2.size.to_f / 0.48

      @mediaDi2 = @mediaDi2 / @learning_results2.size.to_f / 0.48
      @mediaAc2 = @mediaAc2 / @learning_results2.size.to_f / 0.48
      @mediaAs2 = @mediaAs2 / @learning_results2.size.to_f / 0.48
      @mediaCo2 = @mediaCo2 / @learning_results2.size.to_f / 0.48

      #selecao 2

    @selecao2 = params[:selecao2]
    @resultados2 = params[:results2]
    @learning_results2 = []
    @resultados2.each do |result|
      pre = LearningResult.where(data_final: params[:data_final2], id: result).first
      if not pre.nil?
        @learning_results2 << pre
      end
    end
    @mediaEc2 = 0
    @mediaOr2 = 0
    @mediaCa2 = 0
    @mediaEa2 = 0

    @mediaDi2 = 0
    @mediaAc2 = 0
    @mediaAs2 = 0
    @mediaCo2 = 0
    @learning_results2.each do |result|
      @mediaEc2 = @mediaEc2 + result.ec
      @mediaOr2 = @mediaOr2 + result.or
      @mediaCa2 = @mediaCa2 + result.ca
      @mediaEa2 = @mediaEa2 + result.ea
      @mediaDi2 = @mediaDi2 + ((result.ec + result.or) / 2)
      @mediaAc2 = @mediaAc2 + ((result.ec + result.ea) / 2)
      @mediaAs2 = @mediaAs2 + ((result.or + result.ca) / 2)
      @mediaCo2 = @mediaCo2 + ((result.ea + result.ca) / 2)
    end
    @mediaEc2 = (@mediaEc2 / @learning_results2.size.to_f) / 0.48
    @mediaOr2 = @mediaOr2 / @learning_results2.size.to_f / 0.48
    @mediaCa2 = @mediaCa2 / @learning_results2.size.to_f / 0.48
    @mediaEa2 = @mediaEa2 / @learning_results2.size.to_f / 0.48

    @mediaDi2 = @mediaDi2 / @learning_results2.size.to_f / 0.48
    @mediaAc2 = @mediaAc2 / @learning_results2.size.to_f / 0.48
    @mediaAs2 = @mediaAs2 / @learning_results2.size.to_f / 0.48
    @mediaCo2 = @mediaCo2 / @learning_results2.size.to_f / 0.48


      respond_to do |format|
        format.js {}
      end


  end

  def show_by_date
    @selecao = params[:selecao]
    @resultados = params[:results]
    @learning_results = []
    @resultados.each do |result|
      pre = LearningResult.where(data_final: params[:data_final], id: result).first
      if not pre.nil?
        @learning_results << pre
      end
    end
    @mediaEc = 0
    @mediaOr = 0
    @mediaCa = 0
    @mediaEa = 0

    @mediaDi = 0
    @mediaAc = 0
    @mediaAs = 0
    @mediaCo = 0
    @learning_results.each do |result|
      @mediaEc = @mediaEc + result.ec
      @mediaOr = @mediaOr + result.or
      @mediaCa = @mediaCa + result.ca
      @mediaEa = @mediaEa + result.ea
      @mediaDi = @mediaDi + ((result.ec + result.or) / 2)
      @mediaAc = @mediaAc + ((result.ec + result.ea) / 2)
      @mediaAs = @mediaAs + ((result.or + result.ca) / 2)
      @mediaCo = @mediaCo + ((result.ea + result.ca) / 2)
    end
    @mediaEc = (@mediaEc / @learning_results.size.to_f) / 0.48
    @mediaOr = @mediaOr / @learning_results.size.to_f / 0.48
    @mediaCa = @mediaCa / @learning_results.size.to_f / 0.48
    @mediaEa = @mediaEa / @learning_results.size.to_f / 0.48

    @mediaDi = @mediaDi / @learning_results.size.to_f / 0.48
    @mediaAc = @mediaAc / @learning_results.size.to_f / 0.48
    @mediaAs = @mediaAs / @learning_results.size.to_f / 0.48
    @mediaCo = @mediaCo / @learning_results.size.to_f / 0.48




    respond_to do |format|
    format.js {}
  end

end


  def list
    if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id]).all
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
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
      @users = @users.first.to_a
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
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
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids,  type: 'Student')
      end
      @users = @users.first.to_a


    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @center = Center.where(campu_id: params[:campu_id]).first
      @selecao = @center.name
      @courses = Course.where(center_id: params[:center_id]).find_each.to_a
      @users = []
      @courses.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end

    end

    if params[:course_id] != 'todos' && params[:center_id] != nil && params[:center_id] != 'todos'
      @users = User.where(course_id: params[:course_id], type: 'Student').find_each
      @users = @users.to_a
      @course = Course.where(id: params[:course_id]).first
      @selecao = @course.nome
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
        end
      end
      @subject = Subject.where(id: params[:subject_id]).first
      @selecao = @subject.nome
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @users = []
      @classroom.users.each do |user|
        @users << user
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end

      @results = []
      @users.each do |user|
          user.learning_results.each do |result|
            @results << result
          end
      end

    @datas = @results.map(&:data_final).uniq


  end

  def analytic_list
     if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id]).all
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
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
      @users = @users.first.to_a
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
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
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids,  type: 'Student')
      end
      @users = @users.first.to_a


    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @center = Center.where(campu_id: params[:campu_id]).first
      @selecao = @center.name
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
     @courses.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end
    end

    if params[:course_id] != 'todos' && params[:center_id] != nil && params[:center_id] != 'todos'
      @users = User.where(course_id: params[:course_id], type: 'Student').find_each
      @users = @users.to_a
      @course = Course.where(id: params[:course_id]).first
      @selecao = @course.nome
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @classrooms = Classroom.where(subject_id: params[:subject_id]).find_each
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          @users << user
        end
      end
      @subject = Subject.where(id: params[:subject_id]).first
      @selecao = @subject.nome
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @users = []
      @classroom.users.each do |user|
        @users << user
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end

      @results = []
      @users.each do |user|
          user.learning_results.each do |result|
            @results << result
          end
      end

    @datas = @results.map(&:data_final).uniq


    #selecao2

    if params[:institution2_id] == 'todos'
      @users2 = User.where(type: 'Student').find_each
      @selecao2 = "todos os institutos"
    else
      @users2 = User.where(institution_id: params[:institution2_id]).all
      @institution2 = Institution.where(id: params[:institution2_id]).first
      @selecao2 = @institution2.nome
    end

    if params[:campu2_id] == 'todos' && params[:institution2_id] != 'todos'
      @campus2 = Campu.where(institution_id: params[:institution2_id]).find_each
      @institution2 = Institution.where(id: params[:institution2_id]).first
      @selecao2 = @institution2.nome
      @centers2 = []
      @campus2.each do |campus|
          @centers2 << Center.where(campu_id: campus.id)
      end
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.ids)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids)
      end
      @users2 = @users2.first.to_a
    elsif params[:institution2_id] != 'todos'
      @campus2 = Campu.where(id: params[:campu2_id]).first
      @selecao2 = @campus2.name
      @centers2 = @campus2.centers.all
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.id)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids)
      end
    end

    if params[:center2_id] == 'todos' && params[:campu2_id] != 'todos'
      @centers2 = Center.where(campu_id: params[:campu2_id]).find_each
      @campus2 = Campu.where(id: params[:campu2_id]).first
      @selecao2 = @campus2.name
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.id)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids,  type: 'Student')
      end
      @users2 = @users2.first.to_a


    elsif params[:center2_id] != 'todos' && params[:center2_id] != nil
      @center2 = Center.where(campu_id: params[:campu2_id]).first
      @selecao2 = @center2.name
      @courses2 = Course.where(center_id: params[:center2_id]).find_each
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.id,  type: 'Student')
      end
      @users2 = @users2.first.to_a
    end

    if params[:course2_id] != 'todos' && params[:center2_id] != nil && params[:center2_id] != 'todos'
      @users2 = User.where(course_id: params[:course2_id], type: 'Student').find_each
      @users2 = @users2.to_a
      @course2 = Course.where(id: params[:course2_id]).first
      @selecao2 = @course2.nome
    end

    if params[:subject2_id] != 'todos' && params[:subject2_id] != nil
      @classrooms2 = Classroom.where(subject_id: params[:subject2_id]).find_each
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          @users2 << user
        end
      end
      @subject2 = Subject.where(id: params[:subject2_id]).first
      @selecao2 = @subject2.nome
    end

    if params[:classroom2_id] != 'todos' && params[:classroom2_id] != nil
      @classroom2 = Classroom.where(id: params[:classroom2_id]).first
      @selecao2 = "turma " + @classroom2.codigo
      @users2 = []
      @classroom2.users.each do |user|
        @users2 << user
      end
    end

    if params[:users2_id] != 'todos' && params[:users2_id] != nil
      @user2 = User.where(id: params[:users2_id]).first
      @users2 = []
      @users2 << @user2
      @selecao2 = @users2.first.nome
    end

      @results2 = []
      @users2.each do |user|
          user.learning_results.each do |result|
            @results2 << result
          end
      end

    @datas2 = @results2.map(&:data_final).uniq

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
      params.require(:learning_result).permit(:data_final)
    end
end
