class CreateLearningResults < ActiveRecord::Migration
  def change
    create_table :learning_results do |t|
      t.integer :ec
      t.integer :or
      t.integer :ca
      t.integer :ea
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.date :data_final

      t.timestamps null: false
    end
  end
end
