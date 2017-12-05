class CreateFormations < ActiveRecord::Migration
  def change
    create_table :formations do |t|
      t.string :nivel
      t.string :institution
      t.string :course
      t.date :date_start
      t.date :date_end
      t.references :curriculum, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
