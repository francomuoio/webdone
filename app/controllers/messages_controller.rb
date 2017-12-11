class MessagesController < ApplicationController
  before_action :set_github, only: [:index, :create]

  def index
    @projet = Projet.find(params[:projet_id])
    repo = @projet.repository_url.split('/').last
    @dev = @projet.develloppeur_profile
    gitprofile = Github.new oauth_token: current_user.develloppeur_profile.github_token
    data = gitprofile.issues @dev.github_username
    @issues = []
    @collection = []
    @issuedones = []
    labels = []
    comments = []
    @count = 0
    coms = Github::Client::Issues::Comments.new user: @dev.github_username, repo: repo, oauth_token: @dev.github_token # Récupère l'ensemble des commentaires du repo
    data.list.each do |issue|
      issue["labels"].each do |label|
        labels << label["name"]
      end
      coms.list.each do |com|
        comments << { id: com["id"], content: com["body"], owner: com["user"]["login"], number: com["number"], date: com["created_at"] } if com["html_url"].split('#').first == issue["html_url"]
        @count += 1 if com["html_url"].split('#').first == issue["html_url"]
      end
      @issues << { title: issue["title"], label: labels.first, comments: comments }
      @collection << [issue["title"], issue["number"]]
      @issuedones << { title: issue["title"], labels: labels, comments: comments } unless issue[:labels].select { |el| el.values_at("name") == ["done"] }.empty?
      labels = []
      comments = []
    end
  end

  def create
    @projet = Projet.find(params[:projet_id])
    repo = @projet.repository_url.split('/').last
    @dev = @projet.develloppeur_profile
    Github::Client::Issues::Comments.new.create oauth_token: @dev.github_token, user: @dev.github_username, repo: repo, number: params["issue_id"], body: params["body"]
  end

  def destroy
    # Supprimer un message
    fail
  end

  private

  def set_github
    @projet = Projet.find(params[:projet_id])
    repo = @projet.repository_url.split('/').last
    @dev = @projet.develloppeur_profile
  end
end
