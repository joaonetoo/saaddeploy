class CreateWeaknessAnswers < ActiveRecord::Migration
  def change
    create_table :weakness_answers do |t|
      t.string :text
      t.belongs_to :weakness, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
