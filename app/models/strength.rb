class Strength < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :plano
  has_many :strength_answers, dependent: :destroy
end
