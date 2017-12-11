class DonesController < ApplicationController
  require 'json'
  require 'open-uri'

  def index
    @projet = Projet.find(params[:projet_id])
    @dev = @projet.develloppeur_profile
    #data = Github::Client::Issues.new oauth_token: current_user.develloppeur_profile.github_token, repo: @projet.repository_url

    issues = Github::Client::Issues.new oauth_token: @dev.github_token
    data = issues.list #'francomuoio', 'github', state: 'open'
    @arr = []
    # tes issues ou t'es assigné
    gh_username = @dev.github_username
    url = "https://api.github.com/repos/#{gh_username}/#{@projet.title.downcase}"
    data.body.each do |aa|
      # issue = {
      #   comments_url: messages(clean_url(aa["comments_url"])),
      #   repository_url: messages(clean_url(aa["repository_url"])),
      #   labels: messages(clean_url(aa["labels_url"])),
      #   comments: messages(clean_url(aa["comments_url"]))
      #  }
      @arr << aa.title if aa["repository_url"] == url
    end
  end
end
