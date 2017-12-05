class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :description
      t.references :curriculum, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
