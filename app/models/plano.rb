class Plano < ActiveRecord::Base
    belongs_to :user
    has_many :strengths
    has_many :opportunities
    has_many :weaknesses
    has_many :threats
    has_many :objectives
end
