module ApplicationHelper

  def devise_errors_for(resource)
    render partial: "shared/devise_errors", locals: {
      errors: resource.errors.full_messages
    }
  end

end