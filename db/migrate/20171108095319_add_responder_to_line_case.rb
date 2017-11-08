class AddResponderToLineCase < ActiveRecord::Migration
  def change
    add_column :line_cases, :responder, :string
  end
end
