class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
        t.references :sender
        t.references :recipient
        t.string :url
        t.string :description
    end
  end
end
