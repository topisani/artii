module ApplicationHelper
  def insert_flash(list = [:success, :info, :warning, :danger], outer_class = "col-md-5", inner_class = "alert")
    result = "<div class=\"#{outer_class}\">"
    list.each do |i|
      next unless flash[i]
      result << "<div class='#{inner_class} ui #{i} message'>#{flash[i]}</p>"
    end
    result << "</div>"
    result
  end
  def logged_in?
    @current_user != nil
  end
  class ActionView::Helpers::FormBuilder
    def dropzone_field name, options = {}
      options[:class] += " dropzone"
      hidden_field name, options
    end
  end
end
