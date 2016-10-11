class Objective < ActiveRecord::Base
  belongs_to :plano
  has_many :strategies, :dependent => :destroy
end
