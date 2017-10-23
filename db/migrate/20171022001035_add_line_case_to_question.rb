class AddLineCaseToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :line_case, index: true, foreign_key: true
  end
end
