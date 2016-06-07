class CreateAnchors < ActiveRecord::Migration
  def change
    create_table :anchors do |t|
      t.string :nome
      t.text :descricao
      t.text :perfil
      t.text :perspectiva
      t.string :tipo
      t.belongs_to :result, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
