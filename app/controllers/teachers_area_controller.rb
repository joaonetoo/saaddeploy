class TeachersAreaController < ApplicationController
  def index
    @classrooms = current_user.classrooms
  end

  def search_plans
    @classrooms = current_user.classrooms
    @subjects = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
    end
  end

  def list
    @classroom = Classroom.find(params[:classroom_id])
    @students = []
      @classroom.users.each do |user|
        if user.type == 'Student'
            @students << user
        end
      end
  end

  def show_plan
    @plano = Plano.find(params[:plano])
    #@note = Note.new
    #@note.sender_id = current_user
    #@note.recipient_id = @plano.user.id
  end

  def pdf_plan
    respond_to do |format|
      format.html
      format.pdf {
        pdf = Prawn::Document.new
        pdf.text "hello world"
        send_data pdf.render, filename: 'plan.pdf', type: 'application/pdf', disposition: "inline"
      }
    end
  end

  def add_note
    respond_to do |format|
        format.js {}
    end
  end

end
