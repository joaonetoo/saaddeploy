class StudentAreaController < ApplicationController
  def index
    @classrooms = current_user.classrooms
    if current_user.plano != nil
        @plano = current_user.plano
    end
  end
end
