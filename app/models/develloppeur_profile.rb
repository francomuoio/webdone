class DevelloppeurProfile < ApplicationRecord
  has_many :projet
  belongs_to :user
end
