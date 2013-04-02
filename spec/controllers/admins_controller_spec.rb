require 'spec_helper'

describe AdminsController do

  let(:admin_attrs) { Fabricate.attributes_for(:admin) }

  describe "#new" do
    let(:act!) { get :new }

    it_behaves_like :requires_auth
  end

  describe "#create" do
    let(:act!) { post :create, admin: admin_attrs }

    context "unauthenticated" do
      it "redirects to sign_in" do
        act!
        verify_auth_redirect!
      end
    end

    context "authenticated" do
      before { set_admin! }

      it "redirects to root" do
        act!
        response.should redirect_to(root_path)
      end
    end
  end

end
