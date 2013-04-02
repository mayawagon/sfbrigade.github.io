
module AuthHelpers

  # Auth extensions for controller ExampleGroups
  module ExampleGroupExtensions
    extend ActiveSupport::Concern

    module ClassMethods

      # Create a new context block with an authenticated
      # admin, and run the given examples.
      def as_admin &example_group_block
        context "as an admin" do
          before { set_admin! }

          describe "authenticated", &example_group_block
        end
      end

      # Create a new context block indicating no admin.
      def as_visitor &example_group_block
        context "as a visitor", &example_group_block
      end

    end
  end

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

RSpec.configure do |config|
  config.include AuthHelpers::ExampleGroupExtensions, :type => :controller
end