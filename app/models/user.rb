class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :client_profile, dependent: :destroy
  has_one :develloppeur_profile, dependent: :destroy

  # after_create :send_welcome_email

  attr_accessor :repos

  def dev?
    role == 'developpeur'
  end

  def client?
    role == 'client'
  end

  def self.find_or_create_for_github_oauth(auth_hash)
    dp = DevelloppeurProfile.find_by(github_uid: auth_hash[:uid])
    if dp
      dp.update(github_token: auth_hash[:credentials][:token])
      return dp.user
    else
      user = User.new(
        email: auth_hash[:info][:email],
        password: Devise.friendly_token[0,20],
        role: 'developpeur'
      )
      dp = DevelloppeurProfile.new(
        github_uid: auth_hash[:uid],
        github_token: auth_hash[:credentials][:token],
        github_username: auth_hash[:info][:nickname]
      )
      user.develloppeur_profile = dp
      user.save!
      return user
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now if client?
  end
end
