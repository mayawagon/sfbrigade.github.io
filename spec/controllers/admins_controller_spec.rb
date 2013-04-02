require 'spec_helper'

describe AdminsController do

  describe "#index" do
    let(:act!) { get :index }

    it_behaves_like :requires_auth

    as_admin do
      it "sets @admins" do
        act!
        assigns(:admins).should == [ admin ]
      end
    end
  end

  describe "#new" do
    let(:act!) { get :new }

    it_behaves_like :requires_auth

    as_admin do
      it "sets a blank admin" do
        act!
        assigns(:admin).should be_a(Admin)
      end
    end
  end

  describe "#create" do
    let(:valid_admin_attrs) { Fabricate.attributes_for(:admin).merge(email: "pending.admin@codeforamerica.org") }
    let(:admin_attrs) { valid_admin_attrs }
    let(:act!) { post :create, admin: admin_attrs }

    as_visitor do
      it "redirects to sign_in" do
        act!
        verify_auth_redirect!
      end
    end

    as_admin do
      context "email is invalid" do
        let(:admin_attrs) { valid_admin_attrs.merge(email: nil) }

        it "renders new" do
          act!
          response.should render_template(:new)
        end
      end

      context "passwords do not match" do
        let(:admin_attrs) { valid_admin_attrs.merge(password_confirmation: "falafel") }

        it "renders new" do
          act!
          response.should render_template(:new)
        end
      end

      context "admin is valid" do
        it "creates an Admin" do
          expect_difference Admin, :count do
            act!
          end
        end

        it "redirects to admin index" do
          act!
          response.should redirect_to(admins_path)
        end
      end
    end
  end

end
