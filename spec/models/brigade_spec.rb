require 'spec_helper'

describe Brigade do

  it "is a Brigade" do
    Brigade.new.should be_a(Brigade)
  end

end