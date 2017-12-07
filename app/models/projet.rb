class Projet < ApplicationRecord
  belongs_to :develloppeur_profile
  belongs_to :client_profile, optional: true

  validates :title, presence: true
  validates :content, presence: true
end
