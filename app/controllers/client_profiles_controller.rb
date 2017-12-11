class ClientProfilesController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @client = ClientProfile.new
  end

  def create
    @user = current_user
    @client = ClientProfile.new(client_params)
    @client.user = @user
    if @client.save
      redirect_to client_profile_path(@client)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @client.update(client_params)
    redirect_to client_profile_path(@client)
  end

  def destroy
   # ClientProfile.find(params[:id]).destroy (on ne détruit pas un profile !)
   # redirect_to client_profile_path
  end

  private

  def client_params
    params.require(:client_profile).permit(:first_name, :last_name, :phone_number, :photo, :photo_cache)
  end

  def set_client
    @client = ClientProfile.find(params[:id])
  end
end
