class NoteCase < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer_case
end
