class ClientProfile < ApplicationRecord
  has_many :projet, dependent: :destroy
  belongs_to :user

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :phone_number, presence: true, allow_blank: false
  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
end
