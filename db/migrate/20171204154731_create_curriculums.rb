class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.string :resume

      t.timestamps null: false
    end
  end
end
