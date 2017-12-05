class Projet < ApplicationRecord
  belongs_to :develloppeur_profile
  belongs_to :client_profile
end
