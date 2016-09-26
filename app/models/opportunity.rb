class Opportunity < ActiveRecord::Base
  belongs_to :plano
  has_many :opportunity_answers
end
