class LineCase < ActiveRecord::Base
  belongs_to :study_case
  belongs_to :user
  belongs_to :question
  has_and_belongs_to_many :users
  has_many :questions
end
