class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name
      t.belongs_to :campu, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
