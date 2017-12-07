require 'json'
require 'open-uri'

class MessagesController < ApplicationController
  def index
    # Récupérér tous les messages
    @projet = Projet.find(params[:projet_id])
    data = Github::Client::Issues.new oauth_token: current_user.develloppeur_profile.github_token, repo: @projet.repository_url
    hashes = data.list
    @issues = []
    @dones = []
    hashes.each do |issue|
      prems = JSON.parse(open(issue["url"]).read)
      deus = JSON.parse(open("#{issue['url']}/labels").read)
      tres = JSON.parse(open("#{issue['url']}/comments").read)
      @issues << { title: prems["title"], labels: deus, comments: tres, owner: issue["repository"]["owner"]["login"], repo: issue["repository"]["name"] }
      # Lien pour le formulaire : "/repos/#{issue.owner}/#{issue.repo}/issues"
      @dones << issue[:labels].select { |el| el.values_at("name") == ["done"] }.flatten
    end
    fail
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
