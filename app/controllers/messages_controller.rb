require 'json'
require 'open-uri'

class MessagesController < ApplicationController
  def index
    # Récupérér tous les messages
    @projet = Projet.find(params[:projet_id])
    data = Github::Client::Issues.new oauth_token: current_user.develloppeur_profile.github_token, repo: @projet.repository_url
    hashes = data.list
    @issues = []
    hashes.each do |issue|
      prems = JSON.parse(open(issue["url"]).read)
      deus = JSON.parse(open("#{issue['url']}/labels").read)
      tres = JSON.parse(open("#{issue['url']}/comments").read)
      @issues << { title: prems["title"], label: deus, comments: tres }
    end
    fail
  end

  def new
    # Créer un nouveau message
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
