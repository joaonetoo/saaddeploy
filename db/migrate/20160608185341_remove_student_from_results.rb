class RemoveStudentFromResults < ActiveRecord::Migration
  def change
    remove_reference :results, :student, index: true, foreign_key: true
  end
end
