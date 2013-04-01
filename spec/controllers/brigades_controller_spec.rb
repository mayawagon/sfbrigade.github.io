require 'spec_helper'

describe BrigadesController do

  # Shared examples for endpoints which should require authentication
  # using: before_filter :authenticate_admin!
  #
  # Setup by declaring the action:
  #
  # let
  shared_examples_for :requires_auth do

    context "user is not signed in" do
      it "redirects" do
        action
        response.status.should == 302
      end
    end

    context "user is signed in" do
      before { sign_in(:admin, Fabricate(:admin)) }

      it "responds successfully if user is logged in" do
        action
        response.status.should == 200
      end
    end

  end

  describe "#index" do

    let(:action) { get :index }

    it_behaves_like :requires_auth

  end

end