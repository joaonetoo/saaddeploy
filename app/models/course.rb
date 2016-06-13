class Course < ActiveRecord::Base
  belongs_to :center
  has_many :users
  has_many :subjects
  validates :nome, :data_abertura, :turno, :center_id, presence: true
end
