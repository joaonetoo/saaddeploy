class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.date :data_final
      t.integer :tf
      t.integer :gm
      t.integer :au
      t.integer :se
      t.integer :ec
      t.integer :sv
      t.integer :ch
      t.integer :ls
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :quiz, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
