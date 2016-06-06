class Campu < ActiveRecord::Base
  belongs_to :institution
  has_many :centers
end
