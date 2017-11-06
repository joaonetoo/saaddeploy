class AnswerCase < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :note_cases
end
