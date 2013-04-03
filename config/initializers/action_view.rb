
# Override ActionView to not wrap fields with error divs.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  "#{html_tag}".html_safe
end
