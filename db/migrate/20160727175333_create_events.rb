class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :nome
      t.text :apresentacao
      t.text :objetivos
      t.date :inicio
      t.date :fim
      t.boolean :submissao

      t.timestamps null: false
    end
  end
end
