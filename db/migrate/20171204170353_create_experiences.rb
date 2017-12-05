class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :institution
      t.string :office
      t.date :date_start
      t.date :date_end
      t.string :description
      t.references :curriculum, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
