class AddUserToCurriculum < ActiveRecord::Migration
  def change
    add_reference :curriculums, :user, index: true, foreign_key: true
  end
end
