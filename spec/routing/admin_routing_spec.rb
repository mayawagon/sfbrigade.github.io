require 'spec_helper'

describe "admin routing" do

  it "disables registrations" do
    { get: "/admins/sign_up" }.should_not be_routable
    { post: "/admins" }.should_not be_routable
  end

end