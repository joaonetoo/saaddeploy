class AddPublicoToPlanos < ActiveRecord::Migration
  def change
    add_column :planos, :publico, :boolean
  end
end
