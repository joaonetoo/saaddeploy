class AddSemestreToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :semestre, :string
    add_column :classrooms, :ano, :string
  end
end
