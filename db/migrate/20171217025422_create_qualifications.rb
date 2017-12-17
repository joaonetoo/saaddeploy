class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.references :curriculum, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
