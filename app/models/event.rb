class Event < ActiveRecord::Base
    belongs_to :user
    has_many :activities, :dependent => :destroy
    has_many :projects, :dependent => :destroy
    has_many :matriculations, :dependent => :destroy
    has_many :registrations, :dependent => :destroy
end
