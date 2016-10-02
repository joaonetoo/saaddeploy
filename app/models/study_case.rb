class StudyCase < ActiveRecord::Base
    belongs_to :user
    has_attached_file :case_file
    validates_attachment :case_file, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
    has_attached_file :notes_file
    validates_attachment :notes_file, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end
