class DeveloppeursController < ApplicationController
  def show
    @dev = DevelloppeurProfile.find(params[:id])
  end

  def new
    @dev = DevelloppeurProfile.new
  end

  def create
    @dev = DevelloppeurProfile.new()
  end

  def edit
    @dev = DevelloppeurProfile.find(params[:id])
  end

  def update
    @dev = DevelloppeurProfile.find(params[:id])
  end
end
