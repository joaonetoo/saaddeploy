class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :observacao
      t.belongs_to :atividade_extra, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
