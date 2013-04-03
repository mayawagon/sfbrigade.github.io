require 'spec_helper'

describe "admin routing" do

  it "routes GET /admin to admin/admins#home" do
    { get: "/admin" }.should route_to(controller: "admin/admins", action: "home")
  end

  it "disables devise registrations" do
    { get: "/admin/admins/sign_up" }.should_not be_routable
  end

  it "routes GET /admins to admin/admins#index" do
    { get: "/admin/admins" }.should route_to(controller: "admin/admins", action: "index")
  end

  it "routes GET /admins/new to admin/admins#new" do
    { get: "/admin/admins/new" }.should route_to(controller: "admin/admins", action: "new")
  end

  it "routes POST /admins to admin/admins#create" do
    { post: "/admin/admins" }.should route_to(controller: "admin/admins", action: "create")
  end

  it "routes DELETE /admins/:id to admin/admins#destroy" do
    { delete: "/admin/admins/1" }.should route_to(controller: "admin/admins", action: "destroy", id: "1")
  end

end