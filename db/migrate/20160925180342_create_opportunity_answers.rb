class CreateOpportunityAnswers < ActiveRecord::Migration
  def change
    create_table :opportunity_answers do |t|
      t.string :text
      t.belongs_to :opportunity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
