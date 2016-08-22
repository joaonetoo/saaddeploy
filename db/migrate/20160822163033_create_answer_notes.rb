class CreateAnswerNotes < ActiveRecord::Migration
  def change
    create_table :answer_notes do |t|
      t.text :observacao
      t.belongs_to :answer, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
