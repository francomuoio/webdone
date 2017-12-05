class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.find_or_create_for_github_oauth(auth_hash)
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
    else
      redirect_to root_path
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
