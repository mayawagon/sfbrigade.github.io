
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

  it_behaves_like :redirects_visitors

  as_authed_admin do
    it "responds successfully if user is logged in" do
      act!
      expect(response).to be_success
    end
  end

end

# Asserts that as a visitor, requests will be redirected
# to sign in. For auth only paths that do not respond with
# 200 OK (i.e. redirect on success) the success case can
# be written separately in the spec itself:
#
# let(:act!) { delete :destroy, id: some_resource.id }
# it_behaves_like :redirects_visitors
#
# as_authed_admin do
#   it "redirects" do
#     act!
#     response.should redirect_to(some_path)
#   end
# end
shared_examples_for :redirects_visitors do

  as_visitor do
    it "redirects" do
      act!
      verify_auth_redirect!
    end
  end

end