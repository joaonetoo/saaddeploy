class AddUserToPlanos < ActiveRecord::Migration
  def change
    add_reference :planos, :user, index: true, foreign_key: true
  end
end
