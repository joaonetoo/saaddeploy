class AddCourseToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :course, index: true, foreign_key: true
  end
end
