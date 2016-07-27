class AddNormasToEvents < ActiveRecord::Migration
  def change
    add_column :events, :normas, :string, :default => 'nenhuma'
    add_column :events, :deadline, :datetime, :default => Time.now
    add_column :events, :trabalhos, :string, :default => 'nenhum'
    change_column :events, :inicio,  :datetime
    change_column :events, :fim,  :datetime
  end
end
