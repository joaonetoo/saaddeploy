class AddLocalToEvents < ActiveRecord::Migration
  def change
    add_column :events, :local, :string
  end
end
