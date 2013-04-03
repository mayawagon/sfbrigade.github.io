module ApplicationHelper

  def new_admin_session_path
    admin_home_path
  end

  def devise_errors_for(resource)
    render partial: "shared/devise_errors", locals: {
      errors: resource.errors.full_messages
    }
  end

end