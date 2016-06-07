class Result < ActiveRecord::Base
  belongs_to :student
  belongs_to :quiz
  has_many :anchors
end
