class Course < ActiveRecord::Base
  belongs_to :institution
  has_many :users
  validates_associated :institution
  validates :nome, :data_abertura, :turno, :institution_id, presence: true
end
