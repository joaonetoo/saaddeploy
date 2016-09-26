class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.string :deadline
      t.string :text
      t.belongs_to :plano, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
