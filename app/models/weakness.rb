class Weakness < ActiveRecord::Base
  belongs_to :plano
  has_many :weakness_answers
end
