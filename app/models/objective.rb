class Objective < ActiveRecord::Base
  belongs_to :plano
  has_many :strategies
end
