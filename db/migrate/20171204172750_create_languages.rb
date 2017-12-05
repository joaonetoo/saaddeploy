class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :idioma
      t.string :read
      t.string :speak
      t.string :write
      t.string :understand
      t.references :curriculum, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
