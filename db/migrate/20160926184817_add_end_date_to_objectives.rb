class AddEndDateToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :data, :date
  end
end
