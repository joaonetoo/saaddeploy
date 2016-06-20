class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  has_many :anchors,  dependent: :destroy
end
