require 'spec_helper'

describe BrigadeHomeController do

  let(:sf) { Fabricate(:sf_brigade) }
  let(:act!) { get :brigade_home, brigade_slug: sf.slug }

  describe "#brigade_home" do
    before { act! }

    it "finds the brigade by slug" do
      assigns(:brigade).should == sf
    end
  end

end