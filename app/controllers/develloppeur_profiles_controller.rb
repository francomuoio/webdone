class DeveloppeurProfilesController < ApplicationController
  def show
    @dev = DevelloppeurProfile.find(params[:id])
  end
end
