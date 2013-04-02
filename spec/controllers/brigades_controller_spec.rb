require 'spec_helper'

describe BrigadesController do

  let!(:sf) { Fabricate(:sf_brigade) }
  let(:sf_attrs) { Fabricate.attributes_for(:sf_brigade) }
  let(:ny_attrs) { Fabricate.attributes_for(:ny_brigade) }

  describe "#index" do
    let(:act!) { get :index }

    it_behaves_like :requires_auth

    as_authed_admin do
      it "fetches all brigades" do
        act!
        assigns(:brigades).to_a.should == [ sf ]
      end
    end
  end

  describe "#new" do
    let(:act!) { get :new }

    it_behaves_like :requires_auth

    as_authed_admin do
      it "sets an empty Brigade" do
        get :new
        response.should be_success
        assigns(:brigade).should be_a(Brigade)
      end
    end
  end

  describe "#create" do
    let(:act!) { post :create, brigade: ny_attrs }

    it_behaves_like :redirects_visitors

    as_authed_admin do
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
          response.should redirect_to(brigade_path(Brigade.find_by(slug: "ny")))
        end
      end
    end
  end

  describe "#edit" do
    let(:act!) { get :edit, id: sf.id }

    it_behaves_like :requires_auth

    as_authed_admin do
      it "sets the expected brigade" do
        act!
        assigns(:brigade).should == sf
      end
    end
  end

  describe "#update" do
    let(:act!) { put :update, id: sf.id, brigade: sf_attrs.merge(name: "SF") }

    it_behaves_like :redirects_visitors

    as_authed_admin do
      before { act! }

      it "updates the brigade" do
        sf.reload.name.should == "SF"
      end

      it "redirects to the brigade page" do
        response.should redirect_to(brigade_path(Brigade.find_by(slug: "sf")))
      end
    end
  end

  describe "#destroy" do
    let(:act!) { delete :destroy, id: sf.id }

    it_behaves_like :redirects_visitors

    as_authed_admin do
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