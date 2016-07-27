class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :data
      t.string :nome
      t.string :palestrante
      t.belongs_to :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
