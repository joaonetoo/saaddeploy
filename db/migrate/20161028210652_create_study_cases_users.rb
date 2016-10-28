class CreateStudyCasesUsers < ActiveRecord::Migration
  def change
    create_table :study_cases_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :study_case, index: true, foreign_key: true
    end
  end
end