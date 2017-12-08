class MessagesController < ApplicationController
  def index
    @projet = Projet.find(params[:projet_id])
    repo = @projet.repository_url.split('/').last
    gitprofile = Github.new oauth_token: current_user.develloppeur_profile.github_token
    user = gitprofile.users.get["login"]
    data = gitprofile.issues user
    @issues = []
    @issuedones = []
    labels = []
    comments = []
    coms = Github::Client::Issues::Comments.new user: user, repo: repo # Récupère l'ensemble des commentaires du repo
    data.list.each do |issue|
      issue["labels"].each do |label|
        labels << label["name"]
      end
      coms.list.each do |com|
        comments << com["body"] if com["html_url"].split('#').first == issue["html_url"]
      end
      @issues << { id: issue["id"], title: issue["title"], labels: labels, comments: comments }
      @issuedones << { title: issue["title"], labels: labels, comments: comments } unless issue[:labels].select { |el| el.values_at("name") == ["done"] }.empty?
      labels = []
      comments = []
    end
  end

  def new
    # Créer un nouveau message
    @projet = Projet.find(params[:projet_id])
  end

  def create

  end

  def edit
    # Editer unmessage
  end

  def update
  end

  def destroy
    # Supprimer un message
  end
end
