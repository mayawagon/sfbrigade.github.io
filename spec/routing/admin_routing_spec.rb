require 'spec_helper'

describe "admin routing" do

  it "disables registrations" do
    { get: "/admins/sign_up" }.should_not be_routable
  end

  it "routes GET /admins/new to admins#new" do
    { get: "/admins/new" }.should route_to(controller: "admins", action: "new")
  end

  it "routes POST /admins to admins#create" do
    { post: "/admins" }.should route_to(controller: "admins", action: "create")
  end

end