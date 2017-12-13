class DevelloppeurProfile < ApplicationRecord
  has_many :projets
  belongs_to :user
end
