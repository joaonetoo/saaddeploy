class CreateVideoUsers < ActiveRecord::Migration
  def change
    create_table :video_users, id: false do |t|
        t.references :user, index: true, foreign_key: true
        t.references :video, index: true, foreign_key: true
    end
  end
end
