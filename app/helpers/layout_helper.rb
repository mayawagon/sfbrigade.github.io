module LayoutHelper

  def render_head
    render partial: "layouts/head"
  end

  def render_flash_messages
    render partial: "layouts/flash", locals: { flash: flash }
  end

end