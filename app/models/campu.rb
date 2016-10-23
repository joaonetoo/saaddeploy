class Campu < ActiveRecord::Base
  belongs_to :institution
  validates :institution, presence: true
  has_many :centers
  has_one :principal, through: :institution
end
