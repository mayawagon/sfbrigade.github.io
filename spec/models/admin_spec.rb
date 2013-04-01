require 'spec_helper'

describe Admin do

  it "is an admin" do
    Admin.new.should be_a(Admin)
  end

end