class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.date :deadline
      t.string :text
      t.belongs_to :objective, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
