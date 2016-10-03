class CreateLineCases < ActiveRecord::Migration
  def change
    create_table :line_cases do |t|
      t.belongs_to :study_case, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.date :data_final
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
