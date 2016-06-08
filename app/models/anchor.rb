class Anchor < ActiveRecord::Base
  belongs_to :result
  has_one :anchorinfo
end
