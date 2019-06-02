class Member < ApplicationRecord

  has_many :assignments
  has_many :committees, :through => :assignments
end
