class Subject < ActiveRecord::Base
  belongs_to :course
  has_many :classrooms
  validates_associated :course
  validates :nome, :ch, :ementa, :codigo, presence: true
end
