class Admin::AdminsController < ApplicationController

  layout "admin"

  before_filter :authenticate_admin!

  def home
  end

  def index
    render_index
  end

  def create
    admin_attrs = params[:admin] || {}

    @admin = Admin.new(admin_attrs.slice(:email))

    # Admin#password= triggers password salting.
    @admin.password = admin_attrs[:password]
    @admin.password_confirmation = admin_attrs[:password_confirmation]

    if @admin.save
      flash[:notice] = "Created admin: #{@admin.email}"
      redirect_to admins_path
    else
      flash.now[:alert] = "There was an error with the admin."
      render_index
    end
  end

  def destroy
    admin = Admin.find(params[:id])

    if admin == current_admin
      flash[:notice] = "You cannot delete yourself!"
    else
      admin.destroy
      flash[:notice] = "#{admin.email} was deleted"
    end

    redirect_to admins_path
  end

  private

  def render_index
    @admin ||= Admin.new
    @admins = Admin.all
    render :index
  end

end
