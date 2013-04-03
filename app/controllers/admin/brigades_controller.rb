class Admin::BrigadesController < ApplicationController

  layout "admin", except: [ :show ]

  before_filter :authenticate_admin!, :except => [ :show ]

  def index
    @brigades = Brigade.all
  end

  def new
    @brigade = Brigade.new
  end

  def edit
    @brigade = Brigade.find(params[:id])
  end

  def create
    @brigade = Brigade.new(params[:brigade])

    if @brigade.save
      redirect_to admin_brigades_path, notice: "Brigade was successfully created."
    else
      render action: "new"
    end
  end

  def update
    @brigade = Brigade.find(params[:id])

    if @brigade.update_attributes(params[:brigade])
      redirect_to admin_brigades_path, notice: "Brigade was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @brigade = Brigade.find(params[:id])
    @brigade.destroy

    redirect_to admin_brigades_url, notice: "Brigade was successfully deleted."
  end
end
