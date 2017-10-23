class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :study_case
  has_and_belongs_to_many :line_cases
end
