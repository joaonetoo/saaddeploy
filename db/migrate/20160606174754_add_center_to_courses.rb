class AddCenterToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :center, index: true, foreign_key: true
  end
end
