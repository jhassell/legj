class Committee < ApplicationRecord

  has_many :assignments
  has_many :members, :through => :assignments
end
