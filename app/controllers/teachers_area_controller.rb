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

end
