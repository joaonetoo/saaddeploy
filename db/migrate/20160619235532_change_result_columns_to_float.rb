class ChangeResultColumnsToFloat < ActiveRecord::Migration
  def change
    change_column :results, :tf, :float
    change_column :results, :gm, :float
    change_column :results, :au, :float
    change_column :results, :se, :float
    change_column :results, :ec, :float
    change_column :results, :sv, :float
    change_column :results, :ch, :float
    change_column :results, :ls, :float
  end
end