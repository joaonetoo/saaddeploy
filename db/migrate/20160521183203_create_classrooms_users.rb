class CreateClassroomsUsers < ActiveRecord::Migration
  def change
    create_table :classrooms_users, id: false do |t|
      t.references :user, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true
    end
  end
end
