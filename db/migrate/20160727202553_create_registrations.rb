class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :tipo
      t.belongs_to :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
