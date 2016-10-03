class CreateLineCasesUsers < ActiveRecord::Migration
  def change
    create_table :line_cases_users, id: false do |t|
        t.references :user, index: true, foreign_key: true
        t.references :line_case, index: true, foreign_key: true
    end
  end
end
