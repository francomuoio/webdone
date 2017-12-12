class MessagesController < ApplicationController

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
end
