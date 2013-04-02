
# Shared examples for endpoints which should require authentication
# using: before_filter :authenticate_admin!
#
# Declare an `act!` block and run the shared examples
#
# describe "#my_action" do
#   let(:act!) { get :index }
#   it_behaves_like :requires_auth
# end
shared_examples_for :requires_auth do

  context "user is not signed in" do
    it "redirects" do
      act!
      verify_auth_redirect!
    end
  end

  context "user is signed in" do
    before { set_admin! }

    it "responds successfully if user is logged in" do
      act!
      expect(response).to be_success
    end
  end

end