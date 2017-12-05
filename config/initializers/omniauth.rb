Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GT_ID"], ENV["GT_SECRET"], scope: 'user,repo,gist'
end
