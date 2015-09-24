module ApplicationHelper
  def insert_flash(list = [:success, :info, :warning, :danger], outer_class = "col-md-5", inner_class = "alert")
    result = "<div class=\"#{outer_class}\">"
    list.each do |i|
      next unless flash[i]
      result << "<p class='#{inner_class} alert-#{i}'>#{flash[i]}</p>"
    end
    result << "</div>"
    result
  end
  class ActionView::Helpers::FormBuilder
    def dropzone_field name, options = {}
      options[:class] = "dropzone"
      hidden_field name, options
    end
  end
end
