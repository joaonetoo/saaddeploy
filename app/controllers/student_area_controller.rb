class StudentAreaController < ApplicationController
  def index
    @classrooms = current_user.classrooms
    if current_user.plano != nil
        @plano = current_user.plano
        @notes = Note.where(recipient: @plano.user).each.to_a
    end

  end
end
