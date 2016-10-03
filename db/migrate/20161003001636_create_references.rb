class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :text
      t.belongs_to :study_case, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
