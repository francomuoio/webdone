class UsersController < ApplicationController
  def create
    dev = DevelloppeurProfile.find_by user_id: current_user.id
    @projets = Projet.where(develloppeur_profile_id: dev.id)
    projet = Projet.find_by_title(params[:user][:repos])
    # @projet = Projet.find(params[:repository_url])
    email = params[:user][:email]
    pwd = params[:user][:password]

    client_in = User.find_by email: email
    if client_in.nil?
      @user = User.new
      @user.email = email
      @user.password = 'ChangezVotreMdp'
      if @user.save
        # creation de profil
        clientprofile = ClientProfile.create!(
          first_name: 'changezvotreprenom',
          last_name: 'changezvotrenom',
          phone_number: '0000000000',
          remote_photo_url: 'http://via.placeholder.com/150x150',
          user_id: @user.id
        )
        projet.client_profile_id = clientprofile.id
        projet.save!
        # rattachement du profil au projet
        # ajout de la photo
        # save du profil
        redirect_to projets_path
      else
        redirect_to projets_path(projet)
      end

    else
      cli = ClientProfile.find_by user_id: client_in.id
      projet.client_profile_id = cli.id
      if projet.save!
        redirect_to projets_path
      else
        redirect_to projets_path(projet)
      end
    end
  end
end
