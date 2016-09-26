class CreateThreatsAnswers < ActiveRecord::Migration
  def change
    create_table :threats_answers do |t|
      t.string :text
      t.belongs_to :threat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
