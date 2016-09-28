class AddColumnToPlano < ActiveRecord::Migration
  def change
    add_column :planos, :mission, :text
  end
end
