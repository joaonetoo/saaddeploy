class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :nome
      t.date :data_abertura
      t.string :turno
      t.belongs_to :institution, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
