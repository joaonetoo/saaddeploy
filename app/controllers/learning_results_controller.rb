class LearningResultsController < ApplicationController
  before_action :set_learning_result, only: [:show, :edit, :update, :destroy]

  def setup_teacher_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @institution = Institution.find(current_user.institution_id)
    @course = Course.find(current_user.course_id)
    @center = @course.center
    @campu = @center.campu
    @classrooms = current_user.classrooms
    @institutions << @institution
    @courses << @course
    @centers << @center
    @campus << @campu
    @subjects = []
    @students = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
            if user.type == 'Student'
              @students << user
            end
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}
  end
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
    if current_user.type == 'Teacher'
      setup_teacher_search
    end
  end

  def subject_selection
    @subject = Subject.find(params[:subject])
    @classrooms = []
    @subject.classrooms.each do |classroom|
      classroom.users.each do |user|
        if user.id == current_user.id
          @classrooms << classroom
        end
      end
    end

    respond_to do |format|
       format.js {  }
    end
  end

  def classroom_selection
    @classroom = Classroom.find(params[:classroom])
    @users = @classroom.users
  end

  def analytics
  end

  def pdf_list
    @result = LearningResult.find(params[:result])
    student = User.find(@result.user.id)
    @mediaDi = ((@result.ec + @result.or) / 2)
    @mediaAc = ((@result.ec + @result.ea) / 2)
    @mediaAs = ((@result.or + @result.ca) / 2)
    @mediaCo = ((@result.ea + @result.ca) / 2)
    @predominantes = {"co" => @mediaCo, "ac" => @mediaAc, "as" => @mediaAs, "di" => @mediaDi }.sort_by{ |k, v| v }.reverse.to_h
    @predominante1 = LearningStyle.where(sigla: @predominantes.keys[0]).first
    @predominante2 = LearningStyle.where(sigla: @predominantes.keys[1]).first
    respond_to do |format|
      format.html
      format.pdf {
          img = "#{Rails.root}/public/pdf_bg.png"
          Prawn::Document.generate "estilos_de_aprendizagem.pdf" do |pdf|
          #Prawn::Document.generate("background.pdf", :page_size=> "A4",:background => img) do |pdf|
          #pdf.image "#{student.avatar.path(:thumb)}", :scale => 0.75
          pdf.font("Helvetica", :style => :bold)
          pdf.text "Inventário de estilos de aprendizagem", :color => "006699", :align => :center, :size => 18
          pdf.move_down 20
          pdf.text "Nome: #{@result.user.nome.capitalize}",:color => "006699", :align => :center, :size => 14
          pdf.move_down 10
          pdf.text "Realizado em: #{@result.updated_at.strftime("%d/%m/%Y")}", :align => :center, :size => 10
          pdf.move_down 40
          pdf.table([["<color rgb='FFFFFF'>Experiência Concreta</color>", "<color rgb='FFFFFF'>Observação Reflexiva</color>", "<color rgb='FFFFFF'>Conceituação Abstrata</color>", "<color rgb='FFFFFF'>Experiência Ativa</color>"],["#{@result.ec}", "#{@result.or}", "#{@result.ca}", "#{@result.ea}"]], :position => :center, row_colors: ['006699', 'ffffff'], cell_style: { size: 12, align: :center, border_color: "006699", :inline_format => true })
          pdf.move_down 40
          pdf.text "Primeiro estilo predominante: #{@predominante1.nome}",:color => "006699", :align => :left, :size => 14
          pdf.move_down 20
          pdf.font("Helvetica")
          pdf.text "#{@predominante1.descricao}", :align => :left, :size => 12
          pdf.move_down 40
          pdf.font("Helvetica", :style => :bold)
           pdf.text "Segundo estilo predominante: #{@predominante2.nome}",:color => "006699", :align => :left, :size => 14
          pdf.move_down 20
          pdf.font("Helvetica")
          pdf.text "#{@predominante2.descricao}", :align => :left, :size => 12

          send_data pdf.render, filename: 'learning_results.pdf', type: 'application/pdf', disposition: "inline"
        end

      }
    end
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
      @mediaEc = (@mediaEc / @learning_results.size.to_f)
      @mediaOr = @mediaOr / @learning_results.size.to_f
      @mediaCa = @mediaCa / @learning_results.size.to_f
      @mediaEa = @mediaEa / @learning_results.size.to_f

      @mediaDi = @mediaDi / @learning_results.size.to_f
      @mediaAc = @mediaAc / @learning_results.size.to_f
      @mediaAs = @mediaAs / @learning_results.size.to_f
      @mediaCo = @mediaCo / @learning_results.size.to_f
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
    @mediaEc2 = @mediaEc2 / @learning_results2.size.to_f
    @mediaOr2 = @mediaOr2 / @learning_results2.size.to_f
    @mediaCa2 = @mediaCa2 / @learning_results2.size.to_f
    @mediaEa2 = @mediaEa2 / @learning_results2.size.to_f

    @mediaDi2 = @mediaDi2 / @learning_results2.size.to_f
    @mediaAc2 = @mediaAc2 / @learning_results2.size.to_f
    @mediaAs2 = @mediaAs2 / @learning_results2.size.to_f
    @mediaCo2 = @mediaCo2 / @learning_results2.size.to_f

    @eap1 = @mediaCa - @mediaEc
    @eap2 = @mediaEa - @mediaOr


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
      @mediaEc = @mediaEc / @learning_results.size.to_f
      @mediaOr = @mediaOr / @learning_results.size.to_f
      @mediaCa = @mediaCa / @learning_results.size.to_f
      @mediaEa = @mediaEa / @learning_results.size.to_f
      @mediaDi = @mediaDi / @learning_results.size.to_f
      @mediaAc = @mediaAc / @learning_results.size.to_f
      @mediaAs = @mediaAs / @learning_results.size.to_f
      @mediaCo = @mediaCo / @learning_results.size.to_f

      @eap1 = @mediaCa - @mediaEc
      @eap2 = @mediaEa - @mediaOr

    respond_to do |format|
    format.js {}
  end

end


  def list
    if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id], type: 'Student').all
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
          @users << User.where(course_id: course.ids, type: 'Student')
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
          @users << User.where(course_id: course.ids, type: 'Student')
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
          if(user.type == 'Student')
            @users << user
          end
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
        if(user.type == 'Student')
          @users << user
        end
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
      @users = User.where(institution_id: params[:institution_id], type: 'Student').all
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
          @users << User.where(course_id: course.ids, type: 'Student')
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
          @users << User.where(course_id: course.ids, type: 'Student')
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
          if(user.type == 'Student')
            @users << user
          end
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
        if(user.type == 'Student')
          @users << user
        end
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
      @users2 = User.where(institution_id: params[:institution2_id], type: 'Student').all
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
          @users2 << User.where(course_id: course.ids, type: 'Student')
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
          @users2 << User.where(course_id: course.ids, type: 'Student')
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
          if(user.type == 'Student')
            @users2 << user
          end
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
        if(user.type == 'Student')
          @users2 << user
        end
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
    @learning_result.ec = @learning_result.q1a + @learning_result.q2c + @learning_result.q3d + @learning_result.q4a + @learning_result.q5a + @learning_result.q6c + @learning_result.q7b + @learning_result.q8d + @learning_result.q9b + @learning_result.q10b + @learning_result.q11a + @learning_result.q12b
    @learning_result.or = @learning_result.q1d + @learning_result.q2a + @learning_result.q3c + @learning_result.q4c + @learning_result.q5b + @learning_result.q6a + @learning_result.q7a + @learning_result.q8c + @learning_result.q9a + @learning_result.q10a + @learning_result.q11b + @learning_result.q12c
    @learning_result.ca = @learning_result.q1b + @learning_result.q2b + @learning_result.q3a + @learning_result.q4d + @learning_result.q5c + @learning_result.q6d+ @learning_result.q7c + @learning_result.q8b + @learning_result.q9d + @learning_result.q10d + @learning_result.q11c + @learning_result.q12a
    @learning_result.ea = @learning_result.q1c + @learning_result.q2d + @learning_result.q3b + @learning_result.q4b + @learning_result.q5d + @learning_result.q6b + @learning_result.q7d + @learning_result.q8a + @learning_result.q9c + @learning_result.q10c + @learning_result.q11d + @learning_result.q12d
    @learning_result.user_id = current_user.id
    respond_to do |format|
      if @learning_result.save
        format.html { redirect_to welcome_index_path, notice: 'Learning result was successfully created.' }
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
      params.require(:learning_result).permit(:data_final, :q1a, :q1b, :q1c, :q1d, :q2a, :q2b, :q2c, :q2d, :q3a, :q3b, :q3c, :q3d, :q4a, :q4b, :q4c, :q4d, :q5a, :q5b, :q5c, :q5d, :q6a, :q6b, :q6c, :q6d, :q7a, :q7b, :q7c, :q7d, :q8a, :q8b, :q8c, :q8d, :q9a, :q9b, :q9c, :q9d, :q10a, :q10b, :q10c, :q10d, :q11a, :q11b, :q11c, :q11d, :q12a, :q12b, :q12c, :q12d)
    end
end
