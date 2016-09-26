class CreateStrengthAnswers < ActiveRecord::Migration
  def change
    create_table :strength_answers do |t|
      t.string :text
      t.belongs_to :strength, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
