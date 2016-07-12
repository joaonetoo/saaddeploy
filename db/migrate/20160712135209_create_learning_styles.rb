class CreateLearningStyles < ActiveRecord::Migration
  def change
    create_table :learning_styles do |t|
      t.string :nome
      t.text :descricao
      t.string :sigla

      t.timestamps null: false
    end
  end
end
