class DonesController < ApplicationController
  def index
    @projet = Projet.find(params[:projet_id])
    #data = Github::Client::Issues.new oauth_token: current_user.develloppeur_profile.github_token, repo: @projet.repository_url

    issues = Github::Client::Issues.new oauth_token: current_user.develloppeur_profile.github_token
    data = issues.list 'francomuoio', 'github', state: 'open'
    arr = []
    # tes issues ou t'es assigné
    gh_username = current_user.develloppeur_profile.github_username
    url = "https://api.github.com/repos/#{gh_username}/#{@projet.title.downcase}"
    data.body.each do |aa|
      # issue = {
      #   comments_url: aa["comments_url"],
      #   repository_url: aa["repository_url"],
      #   labels: aa["labels_url"]
          # comments: messages(aa["comments_url"])
      # }
      arr << aa.title if aa["repository_url"] == url
    end

    fail
  end

  def show
  end

  private

  # def messages(url)
  #   return [messages, messages]
  # end
end



# prendre toutes les issues en format hash.
# pour chaque issues afficher le label uniquement si la valeure du label est done.
