class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campus do |t|
      t.string :name
      t.belongs_to :institution, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
