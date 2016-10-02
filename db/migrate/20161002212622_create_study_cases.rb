class CreateStudyCases < ActiveRecord::Migration
  def change
    create_table :study_cases do |t|
      t.string :title
      t.string :author
      t.string :area
      t.string :topic
      t.string :topic2
      t.string :recommended
      t.text :abstract

      t.timestamps null: false
    end
  end
end
