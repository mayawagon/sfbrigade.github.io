
require 'spec_helper'

describe "brigade routing" do

  describe "brigade_home routes" do
    it "routes GET /:brigade_slug to brigade_home#brigade_home" do
      { get: "/sf" }.should route_to({
        controller: "brigade_home",
        action: "brigade_home",
        brigade_slug: "sf"
      })
    end

    it "matches all other routes first" do
      { get: "/admin" }.should route_to(controller: "admin/admins", action: "home")
    end
  end

end