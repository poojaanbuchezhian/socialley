module ApplicationHelper
  require 'string'
  require 'object'
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
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :id => nil,
    :action => action,
    :controller => controller
  end
  def paginated?
    @pages and @pages.length > 1
  end

end
