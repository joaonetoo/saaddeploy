class Video < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_and_belongs_to_many :recipients, :class_name => 'User', :join_table => :videos_users

  public
      def youtubeRegExp(url)
        url.match(/(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/)[5]
      end
end
