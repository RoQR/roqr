module ApplicationHelper
  def style_if_active(path, active, inactive)
    if current_page?(path)
      active
    else
      inactive
    end
  end
end
