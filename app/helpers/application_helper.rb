module ApplicationHelper
  require 'string'
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :controller => controller,
    :action => action
  end
  def logged_in?
    not session[:user_id].nil?
  end
  def text_field_for(form, field, size=15, maxlength=255)
      label = content_tag("label", "#{field.humanize}:", :for => field)
      form_field = form.text_field field, :size => size, :maxlength => maxlength
      content_tag("div", "#{label}#{form_field}", :class => "form_row")
  end
end
