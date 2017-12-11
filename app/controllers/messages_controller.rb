class MessagesController < ApplicationController
  before_action :set_github, only: [:index, :create]

  def index
    @projet = Projet.find(params[:projet_id])
    service = GithubIssuesService.new(current_user.develloppeur_profile.github_token)
    @issues = service.get_issues(@projet)
    @comments = service.get_comments(@projet)
  end

  def create
    projet = Projet.find(params[:projet_id])
    service = GithubIssuesService.new(current_user.develloppeur_profile.github_token)
    service.create_comment(projet, params[:issue_number], params[:body])
    redirect_to projet_messages_path(projet)
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
