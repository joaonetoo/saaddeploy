class RenameVideoUsersToVideosUsers < ActiveRecord::Migration
  def change
    rename_table :video_users, :videos_users
  end
end
