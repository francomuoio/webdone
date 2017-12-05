class DevelloppeurProfile < ApplicationRecord
  has_many :projet
  belongs_to :user
  devise :omniauthable, omniauth_providers: [:github]

  def self.find_for_github_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = DevelloppeurProfile.find_by(provider: auth.provider, uid: auth.uid)
    user ||= DevelloppeurProfile.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = DevelloppeurProfile.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end
end
