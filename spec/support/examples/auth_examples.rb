
# Shared examples for endpoints which should require authentication
# using: before_filter :authenticate_admin!
#
# Declare an `action` and run the shared examples
#
# describe "#my_action" do
#   let(:action) { get :index }
#   it_behaves_like :requires_auth
# end
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