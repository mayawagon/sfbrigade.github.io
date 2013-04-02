
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

  as_visitor do
    it "redirects" do
      act!
      verify_auth_redirect!
    end
  end

  as_admin do
    it "responds successfully if user is logged in" do
      act!
      expect(response).to be_success
    end
  end

end