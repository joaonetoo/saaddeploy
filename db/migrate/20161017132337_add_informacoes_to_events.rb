class AddInformacoesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :informacoes, :text
  end
end
