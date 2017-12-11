class MessagesController < ApplicationController
  before_action :set_github, only: [:index, :create]

  def index

  end

  def create

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
