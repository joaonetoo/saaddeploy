class CreateAnchorinfos < ActiveRecord::Migration
  def change
    create_table :anchorinfos do |t|
      t.string :nome
      t.text :descricao
      t.text :perfil
      t.text :perspectiva
      t.string :tipo

      t.timestamps null: false
    end
  end
end
