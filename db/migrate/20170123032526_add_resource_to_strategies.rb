class AddResourceToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :resource, :string
    add_column :strategies, :factor, :string
  end
end
