class AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def new
  end

  def create
    redirect_to root_path
  end

end
