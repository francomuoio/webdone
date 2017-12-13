require 'json'
require 'open-uri'

class ProjetsController < ApplicationController
  before_action :has_profile

  def has_profile
    if current_user.role == "client" && current_user.client_profile.nil?
      redirect_to new_client_profile_path
    end
  end

  def index
      # repos = Github::Client::Repos.new oauth_token: current_user.develloppeur_profile.github_token
    if current_user.role == "developpeur"
      dev = DevelloppeurProfile.find_by user_id: current_user.id
      @projets = Projet.where(develloppeur_profile_id: dev.id)
      @repolist = []
      @projets.each do |projet|
        @repolist << projet.title
      end
      @service = GithubIssuesService.new(current_user.develloppeur_profile.github_token)
    elsif current_user.client_profile.nil?
      redirect_to new_client_profile_path
    else
      client = ClientProfile.find_by user_id: current_user.id
      @projets = Projet.where(client_profile_id: client.id)
    end
  end

  def show
    @projet = Projet.find(params[:id])
    @service = GithubIssuesService.new(@projet.develloppeur_profile.github_token)
  end

  def new
    @projet = Projet.new
    repos = Github::Client::Repos.new oauth_token: current_user.develloppeur_profile.github_token
    @repolist = []
    repos.list.each do |repo|
      @repolist << [repo[:name], repo[:url]]
    end
    clientele = ClientProfile.all
    @clients = []
    clientele.each do |cli|
      @clients << ["#{cli.first_name} #{cli.last_name}", cli.id]
    end
    authorize @projet
  end

  def create
    @projet = Projet.new(projet_params)
    @projet.develloppeur_profile = DevelloppeurProfile.find_by user_id: current_user.id
    authorize @projet
    if @projet.save
      redirect_to projet_dones_path(@projet)
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

#pour date faire une logique client et developpeur.
