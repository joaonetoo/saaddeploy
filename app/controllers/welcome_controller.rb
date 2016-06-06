class WelcomeController < ApplicationController
  def index
    if user_signed_in? && current_user.type == "Administrator"
        redirect_to admin_index_url

    elsif user_signed_in?
        @classrooms = current_user.classrooms

    else

        redirect_to new_user_session_path

    end


  end
end
