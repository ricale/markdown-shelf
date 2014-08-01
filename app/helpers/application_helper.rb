module ApplicationHelper
  def icon_link_to(icon, url, options)
    label = options[:label].nil? ? "" : "&nbsp;#{options[:label]}"
    link_to "<span class='glyphicon glyphicon-#{icon}'></span>#{label}".html_safe, url, options
  end

  def glyphicon_icon(icon_name)
    "<span class='glyphicon glyphicon-#{icon_name}'></span>".html_safe
  end

  def check_box_button(id, value, checked, label, options = {})
    toggle    = (options[:tooltip].nil? or !options[:tooltip]) ?    "" : " data-toggle='tooltip'"
    title     = options[:title].nil?                           ?    "" : " title='#{options[:title]}'"
    css_class = options[:class].nil?                           ? 'btn' : options[:class]
    css_class << ' active' if checked
    css_class << ' default-tooltip' if options[:tooltip]

    check_box = check_box_tag id, value, checked

    "<div class='btn-group' data-toggle='buttons'>
      <label class='#{css_class}'#{toggle}#{title}>
        #{check_box}
        #{label}
      </label>
    </div>".html_safe
  end

  def icon_button_to
  end
end
