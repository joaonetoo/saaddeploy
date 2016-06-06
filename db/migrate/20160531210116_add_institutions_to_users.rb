class AddInstitutionsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :institution, index: true, foreign_key: true
  end
end
