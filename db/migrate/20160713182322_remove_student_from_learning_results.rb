class RemoveStudentFromLearningResults < ActiveRecord::Migration
  def change
    remove_reference :learning_results, :student, index: true, foreign_key: true
  end
end
