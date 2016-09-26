class CreateStrengths < ActiveRecord::Migration
  def change
    create_table :strengths do |t|
      t.string :text
      t.belongs_to :plano, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
