class Project < ActiveRecord::Base
  belongs_to :event
  has_attached_file :file
  validates_attachment :file, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end
