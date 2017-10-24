class CreateAnswerCases < ActiveRecord::Migration
  def change
    create_table :answer_cases do |t|
      t.string :resposta
      t.references :user, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
