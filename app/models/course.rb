class Course < ActiveRecord::Base
  has_many :users
  validates :nome, :data_abertura, :turno, :institution_id, presence: true
end
