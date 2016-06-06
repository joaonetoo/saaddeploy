class CreateCoordinators < ActiveRecord::Migration
  def change
    create_table :coordinators do |t|

      t.timestamps null: false
    end
  end
end
