class RemoveQuestionFromLineCase < ActiveRecord::Migration
  def change
    remove_reference :line_cases, :question, index: true, foreign_key: true
  end
end
