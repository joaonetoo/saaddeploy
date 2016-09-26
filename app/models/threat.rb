class Threat < ActiveRecord::Base
  belongs_to :plano
  has_many :threats_answers
end
