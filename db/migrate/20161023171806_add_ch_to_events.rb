class AddChToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ch, :integer
  end
end
