class AddUserToResults < ActiveRecord::Migration
  def change
    add_reference :results, :user, index: true, foreign_key: true
  end
end
