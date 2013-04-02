require 'spec_helper'

describe BrigadesController do

  let!(:sf) { Fabricate(:sf_brigade) }
  let(:sf_attrs) { Fabricate.attributes_for(:sf_brigade) }
  let(:ny_attrs) { Fabricate.attributes_for(:ny_brigade) }

  describe "#index" do
    let(:act!) { get :index }

    it_behaves_like :requires_auth

    as_admin do
      it "fetches all brigades" do
        act!
        assigns(:brigades).should == [ sf ]
      end
    end
  end

  describe "#new" do
    let(:act!) { get :new }

    it_behaves_like :requires_auth

    as_admin do
      it "sets an empty Brigade" do
        get :new
        response.should be_success
        assigns(:brigade).should be_a(Brigade)
      end
    end
  end

  describe "#create" do
    let(:act!) { post :create, brigade: ny_attrs }

    as_visitor do
      it "redirects to sign_in" do
        act!
        verify_auth_redirect!
      end
    end

    as_admin do
      context "brigade is invalid" do
        let(:act!) { post :create, brigade: ny_attrs.merge(name: nil) }

        it "responds successfully" do
          act!
          response.should be_success
        end

        it "does not create a Brigade" do
          expect_no_difference(Brigade, :count) { act! }
        end
      end

      context "brigade is valid" do
        it "creates a new Brigade" do
          expect_difference(Brigade, :count) { act! }
        end

        it "redirects to the new brigade path" do
          act!
          response.should redirect_to(brigade_path(Brigade.find_by_slug("ny")))
        end
      end
    end
  end

  describe "#edit" do
    let(:act!) { get :edit, id: sf.id }

    it_behaves_like :requires_auth

    as_admin do
      it "sets the expected brigade" do
        act!
        assigns(:brigade).should == sf
      end
    end
  end

  describe "#update" do
    let(:act!) { put :update, id: sf.id, brigade: sf_attrs.merge(name: "SF") }

    as_visitor do
      it "redirects to sign_in" do
        act!
        verify_auth_redirect!
      end
    end

    as_admin do
      before { act! }

      it "updates the brigade" do
        sf.reload.name.should == "SF"
      end

      it "redirects to the brigade page" do
        response.should redirect_to(brigade_path(Brigade.find_by_slug("sf")))
      end
    end
  end

  describe "#destroy" do
    let(:act!) { delete :destroy, id: sf.id }

    as_visitor do
      it "redirects to sign_in" do
        act!
        verify_auth_redirect!
      end
    end

    as_admin do
      it "destroys the brigade" do
        expect_difference Brigade, :count, -1 do
          act!
        end
      end

      it "redirects to brigades_path" do
        act!
        response.should redirect_to(brigades_path)
      end
    end
  end

  describe "#show" do
    let(:act!) { get :show, id: sf.id }

    it "does not require authentication" do
      act!
      response.should be_success
    end

    it "assigns the expected brigade" do
      act!
      assigns(:brigade).should == sf
    end
  end

end