class Center < ActiveRecord::Base
  belongs_to :campu
  has_many :courses
  validates :name, :campu_id, presence: true
end
