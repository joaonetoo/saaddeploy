class Video < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_many :recipients, :class_name => 'User'
end
