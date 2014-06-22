module ApplicationHelper
  def icon_link_to(icon, url, options)
    label = options[:label].nil? ? "" : "&nbsp;#{options[:label]}"
    link_to "<span class='glyphicon glyphicon-#{icon}'></span>#{label}".html_safe, url, options
  end

  def icon_button_to
  end
end
