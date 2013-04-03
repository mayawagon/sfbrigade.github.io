require 'spec_helper'

describe "admin routing" do

  it "routes GET /admin to admins#home" do
    { get: "/admin" }.should route_to(controller: "admins", action: "home")
  end

  it "disables registrations" do
    { get: "/admins/sign_up" }.should_not be_routable
  end

  it "routes GET /admins to admins#index" do
    { get: "/admins" }.should route_to(controller: "admins", action: "index")
  end

  it "routes GET /admins/new to admins#new" do
    { get: "/admins/new" }.should route_to(controller: "admins", action: "new")
  end

  it "routes POST /admins to admins#create" do
    { post: "/admins" }.should route_to(controller: "admins", action: "create")
  end

  it "routes DELETE /admins/:id to admins#destroy" do
    { delete: "/admins/1" }.should route_to(controller: "admins", action: "destroy", id: "1")
  end

end