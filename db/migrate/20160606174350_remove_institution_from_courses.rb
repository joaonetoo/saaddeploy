class RemoveInstitutionFromCourses < ActiveRecord::Migration
  def change
    remove_reference :courses, :institution, index: true, foreign_key: true
  end
end
