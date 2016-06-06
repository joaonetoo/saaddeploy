class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :nome
      t.integer :ch
      t.text :ementa
      t.string :codigo
      t.belongs_to :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
