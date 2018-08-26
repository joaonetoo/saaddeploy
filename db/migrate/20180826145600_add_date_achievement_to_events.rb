class AddDateAchievementToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date_achievement, :string
  end
end
