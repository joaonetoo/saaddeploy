class Plano < ActiveRecord::Base
    belongs_to :user
    has_many :strengths, :dependent => :destroy
    has_many :opportunities, :dependent => :destroy
    has_many :weaknesses, :dependent => :destroy
    has_many :threats, :dependent => :destroy
    has_many :objectives, :dependent => :destroy
end
