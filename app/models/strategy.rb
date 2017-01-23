class Strategy < ActiveRecord::Base
  belongs_to :objective
  validates :resource, :factor, :text, :deadline, presence: true
end
