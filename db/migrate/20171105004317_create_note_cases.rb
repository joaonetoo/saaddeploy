class CreateNoteCases < ActiveRecord::Migration
  def change
    create_table :note_cases do |t|
      t.string :observacao
      t.references :user, index: true, foreign_key: true
      t.references :answer_case, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
