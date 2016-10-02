class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :statement
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :study_case, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
