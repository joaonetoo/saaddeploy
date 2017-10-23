class CreateMainThemes < ActiveRecord::Migration
  def change
    create_table :main_themes do |t|
      t.string :descricao

      t.timestamps null: false
    end
  end
end
