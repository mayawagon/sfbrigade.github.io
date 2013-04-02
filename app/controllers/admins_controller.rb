class AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
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
      render :new
    end
  end

end
