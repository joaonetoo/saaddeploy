class AddFileToProject < ActiveRecord::Migration
  def change
    add_attachment :projects, :file
  end
end
