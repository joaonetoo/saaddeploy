class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.belongs_to :subject, index: true, foreign_key: true
      t.string :turno
      t.string :codigo

      t.timestamps null: false
    end
  end
end
