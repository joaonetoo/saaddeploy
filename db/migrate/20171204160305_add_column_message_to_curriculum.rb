class AddColumnMessageToCurriculum < ActiveRecord::Migration
  def change
    add_column :curriculums, :message, :string
  end
end
