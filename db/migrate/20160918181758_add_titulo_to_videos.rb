class AddTituloToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :titulo, :string
  end
end
