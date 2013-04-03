require 'spec_helper'

describe AdminsController do

  describe "#index" do
    let(:act!) { get :index }

    it_behaves_like :requires_auth

    as_authed_admin do
      before { act! }

      it "sets @admins" do
        assigns(:admins).should == [ authed_admin ]
      end

      it "sets a blank @new_admin for the admin form" do
        assigns(:admin).should be_a(Admin)
      end
    end
  end

  describe "#create" do
    let(:valid_admin_attrs) { Fabricate.attributes_for(:admin).merge(email: "pending.admin@codeforamerica.org") }
    let(:admin_attrs) { valid_admin_attrs }
    let(:act!) { post :create, admin: admin_attrs }

    it_behaves_like :redirects_visitors

    as_authed_admin do
      shared_examples_for :failed_admin_create do
        before { act! }

        it "sets @admins" do
          assigns(:admins).should == [ authed_admin ]
        end

        it "render the index" do
          response.should render_template(:index)
        end

        it "sets a flash message" do
          flash.now[:alert].should_not be_empty
        end
      end

      context "email is invalid" do
        let(:admin_attrs) { valid_admin_attrs.merge(email: nil) }

        it_behaves_like :failed_admin_create
      end

      context "passwords do not match" do
        let(:admin_attrs) { valid_admin_attrs.merge(password_confirmation: "falafel") }

        it_behaves_like :failed_admin_create
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

  describe "#destroy" do
    let!(:admin) { Fabricate(:another_admin) }
    let(:act!) { delete :destroy, id: admin.id }

    it_behaves_like :redirects_visitors

    as_authed_admin do
      it "deletes the admin" do
        expect_difference Admin, :count, -1 do
          act!
        end
      end

      it "redirects to admins index" do
        act!
        response.should redirect_to(admins_path)
      end

      it "sets a flash message" do
        act!
        flash[:notice].should == "#{admin.email} was deleted"
      end

      it "does not delete the current admin" do
        expect_no_difference Admin, :count do
          delete :destroy, id: authed_admin.id
        end
      end
    end
  end

end
