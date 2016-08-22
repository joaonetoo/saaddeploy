class AddStatusToAnswer < ActiveRecord::Migration
  def change
   add_column :answers, :status, :string, :default => 'aberta'
  end
end
