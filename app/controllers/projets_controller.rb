require 'json'
require 'open-uri'

class ProjetsController < ApplicationController
  def index
    if current_user.role == "developpeur"
      @projets = Projet.where(develloppeur_profile_id = current_user.profile.id)
    else
      @projets = Projet.where(client_profile_id = current_user.profile.id)
    end
  end

  def show
    @projet = Projet.find(params[:id])
  end

  def new
    @projet = Projet.new
    repos = Github::Client::Repos.new oauth_token: current_user.develloppeur_profile.github_token
    @repolist = []
    repos.list.each do |repo|
      @repolist << [repo[:name], repo[:url]]
    end
    # clientele = ClientProfile.all
    # @clients = []
    # clientele.each do |cli|
    #   @clients << ["#{cli.first_name} #{cli.last_name}", cli.id]
    # end
  end

  def create
    @projet = Projet.new(projet_params)
    @projet.develloppeur_profile = current_user.develloppeur_profile
    fail
    if @projet.save

    else
      render :new
    end
  end

  def edit
  end

  def update
    @projet = Projet.new(projet_params)
    @projet.develloppeur_profile
    @projet.client_profile
  end

  private

  def projet_params
    params.require(:projet).permit(:title, :content, :repository_url)
  end
end
