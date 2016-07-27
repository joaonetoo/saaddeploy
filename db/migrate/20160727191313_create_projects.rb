class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :titulo
      t.string :autor
      t.string :email
      t.text :resumo
      t.string :tags
      t.string :tipo
      t.string :estado
      t.belongs_to :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
