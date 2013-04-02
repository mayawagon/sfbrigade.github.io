
module AuthHelpers

  # Create an admin session, and set the logged in
  # @admin instance variable.
  def set_admin!(admin = nil)
    @admin ||= Fabricate(:admin)
    sign_in(:admin, @admin)
  end

  # Assert that the response redirected to
  # the admin sign_in path.
  def verify_auth_redirect!
    response.should be_redirect
    response.should redirect_to("/admins/sign_in")
  end

end