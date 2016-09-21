class Center < ActiveRecord::Base
  belongs_to :campu
  has_many :courses

end
