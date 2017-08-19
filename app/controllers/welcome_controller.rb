class WelcomeController < ApplicationController
  def index
    if user_signed_in? && current_user.type == "Administrator"
        redirect_to admin_index_url, notice: "Bem Vindo Ao SAAD"

    elsif user_signed_in? && current_user.type == "Student"
        #@classrooms = current_user.classrooms
        redirect_to student_area_index_path, notice: "Bem Vindo Ao SAAD"
    elsif user_signed_in? && current_user.type == "Teacher"
        redirect_to teachers_area_index_path, notice: "Bem Vindo Ao SAAD"

    elsif user_signed_in? && current_user.type == "Coordinator"
        redirect_to coordinators_area_index_path, notice: "Bem Vindo Ao SAAD"

    elsif user_signed_in? && current_user.type == "Principal"
        redirect_to principals_area_index_path, notice: "Bem Vindo Ao SAAD"
    else
        redirect_to new_user_session_path
    end


  end
end
