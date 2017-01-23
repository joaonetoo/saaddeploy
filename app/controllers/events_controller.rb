class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :permission_check, only: [:index, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:public_events, :public_show]

  def check_privilege(event)
     unless current_user.id == event.user_id
      redirect_to welcome_index_path
      return
    end
  end

  # GET /events
  # GET /events.json
  def public_events
    @events = Event.all
  end

  def approve_project
    @project = Project.find(params[:project])
    @project.estado = 'aprovado'
    @project.save
    redirect_to @project.event
  end

  def public_show
    @event = Event.find(params[:event])
  end

  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    check_privilege(@event)
    @projects = @event.projects
    @activities = @event.activities
    @matriculations = @event.matriculations
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def pdf_event
    @event = Event.find(params[:event])
    respond_to do |format|
      format.html
      format.pdf {
          img = "#{Rails.root}/public/bg_folder.jpg"
          #Prawn::Document.generate "estilos_de_aprendizagem.pdf" do |pdf|
          Prawn::Document.generate("background.pdf", :page_size=> "A4",:background => img) do |pdf|
          pdf.image "#{@event.image.path(:thumb)}", :position => :center
          pdf.font("Helvetica", :style => :bold)
          pdf.move_down 50
          pdf.text "#{@event.nome}", :align => :center,:color => "006699", :size => 18
          pdf.move_down 50
          pdf.image "#{Rails.root}/public/icon_apresentacao.png"
          pdf.move_down 5
          pdf.text "Apresentação: #{@event.apresentacao}", :align => :left,:color => "006699", :size => 18
          pdf.move_down 40
          pdf.image "#{Rails.root}/public/icon_objetivo.png"
          pdf.move_down 5
          pdf.text "Objetivo: #{@event.objetivos}", :align => :left,:color => "006699", :size => 18
          pdf.move_down 40
          pdf.image "#{Rails.root}/public/icon_inscricao.png"
          pdf.move_down 5
          pdf.text "Informações: #{@event.informacoes}", :align => :left,:color => "006699", :size => 18
          pdf.move_down 40
          pdf.image "#{Rails.root}/public/icon_data.png"
          pdf.move_down 5
          pdf.text "Data: #{@event.inicio.strftime("%-d/%-m/%y às %H:%M")}", :align => :left,:color => "006699", :size => 18
          pdf.move_down 40
          pdf.image "#{Rails.root}/public/icon_local.png"
          pdf.move_down 5
          pdf.text "Local: #{@event.local}", :align => :left,:color => "006699", :size => 18


          send_data pdf.render, filename: 'learning_results.pdf', type: 'application/pdf', disposition: "inline"
        end
      }
    end

  end

  def certificate_project
    @event = Event.find(params[:event])
        @projects = Project.find(params[:projects])
        @project = @projects.first
        @projects.shift
      respond_to do |format|
      format.pdf {
          img = "#{Rails.root}/public/background_certificado.jpg"
          #Prawn::Document.generate "estilos_de_aprendizagem.pdf" do |pdf|
          Prawn::Document.generate("background.pdf", :page_size=> "A4", :page_layout=> :landscape, :background => img) do |pdf|
          #pdf.image "#{student.avatar.path(:thumb)}", :scale => 0.75
          pdf.font("Helvetica", :style => :bold)
          pdf.move_down 250
          pdf.text "Declaro para os devidos fins que #{@project.autor.capitalize} apresentou/apresentaram o trabalho intitulado #{@project.titulo}, no evento #{@event.nome}, realizado em #{l(@event.inicio, format: '%d de %B, de %Y')} no(a) #{@event.local}", :align => :center,:color => "006699", :size => 18
          pdf.move_down 150
          pdf.move_down 10
          pdf.text "#{current_user.nome.capitalize}", :align => :center,:color => "006699", :size => 18
          pdf.move_down 10
          pdf.text "Coordenador", :align => :center,:color => "006699", :size => 16
          @projects.each do |project|
            pdf.start_new_page(:page_size=> "A4", :page_layout=> :landscape, :background => img)
            pdf.move_down 250
            pdf.text "Declaro para os devidos fins que #{project.autor.capitalize} apresentaram o trabalho intitulado #{project.titulo}, no evento #{@event.nome}, realizado em #{l(@event.inicio, format: '%d de %B, de %Y')} no(a) #{@event.local}", :align => :center,:color => "006699", :size => 18
            pdf.move_down 150
            pdf.text "#{current_user.nome.capitalize}", :align => :center,:color => "006699", :size => 18
            pdf.move_down 10
            pdf.text "Coordenador", :align => :center,:color => "006699", :size => 16
          end


          send_data pdf.render, filename: 'certificado.pdf', type: 'application/pdf', disposition: "inline"
        end
      }
    end
  end

  def certificate_event
        @event = Event.find(params[:event])
        @matriculations = Matriculation.find(params[:matriculations])
        @matriculation = @matriculations.first
        @matriculations.shift
      respond_to do |format|
      format.pdf {
          img = "#{Rails.root}/public/background_certificado.jpg"
          #Prawn::Document.generate "estilos_de_aprendizagem.pdf" do |pdf|
          Prawn::Document.generate("background.pdf", :page_size=> "A4", :page_layout=> :landscape, :background => img) do |pdf|
          #pdf.image "#{student.avatar.path(:thumb)}", :scale => 0.75
          pdf.font("Helvetica", :style => :bold)
          pdf.move_down 250
          pdf.text "Declaro para os devidos fins que #{@matriculation.nome.capitalize} participou do(a) #{@event.nome}, com carga horária de #{@event.ch} horas, realizado em #{l(@event.inicio, format: '%d de %B, de %Y')} no(a) #{@event.local}", :align => :center,:color => "006699", :size => 18
          pdf.move_down 150
          pdf.move_down 10
          pdf.text "#{current_user.nome.capitalize}", :align => :center,:color => "006699", :size => 18
          pdf.move_down 10
          pdf.text "Coordenador", :align => :center,:color => "006699", :size => 16
          @matriculations.each do |matriculation|
            pdf.start_new_page(:page_size=> "A4", :page_layout=> :landscape, :background => img)
            pdf.move_down 250
            pdf.text "Declaro para os devidos fins que #{matriculation.nome.capitalize} participou do(a) #{@event.nome}, com carga horária de #{@event.ch} horas, realizado em #{l(@event.inicio, format: '%d de %B, de %Y')} no(a) #{@event.local}", :align => :center,:color => "006699", :size => 18
            pdf.move_down 150
            pdf.text "#{current_user.nome.capitalize}", :align => :center,:color => "006699", :size => 18
            pdf.move_down 10
            pdf.text "Coordenador", :align => :center,:color => "006699", :size => 16
          end


          send_data pdf.render, filename: 'certificado.pdf', type: 'application/pdf', disposition: "inline"
        end
      }
    end

  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def permission_check
      if current_user.type == 'Administrator' || current_user.type == 'Coordinator' || current_user.type == 'Principal'
      else
        redirect_to welcome_index_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:nome, :ch,:informacoes,:apresentacao, :objetivos, :inicio, :fim, :submissao, :trabalhos, :deadline, :normas, :local, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at)
    end
end
