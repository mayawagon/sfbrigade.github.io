
module AuthHelpers

  # Auth extensions for controller ExampleGroups
  module ExampleGroupExtensions
    extend ActiveSupport::Concern

    module ClassMethods

      # Create a new context block with an authenticated
      # admin, and run the given examples.
      def as_authed_admin &example_group_block
        context "as an admin" do
          let!(:authed_admin) { Fabricate(:admin) }
          before { sign_in :admin, authed_admin }

          describe "authenticated", &example_group_block
        end
      end

      # Create a new context block indicating no admin.
      def as_visitor &example_group_block
        context "as a visitor", &example_group_block
      end

    end
  end

  # Assert that the response redirected to
  # the admin sign_in path.
  def verify_auth_redirect!
    response.should be_redirect
    response.should redirect_to("/admins/sign_in")
  end

end