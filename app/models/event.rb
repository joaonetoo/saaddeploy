class Event < ActiveRecord::Base
    belongs_to :user
    has_many :activities
    has_many :projects
    has_many :matriculations
end
