module ApplicationHelper
  def style_if_active(path, active, inactive)
    if current_page?(path)
      active
    else
      inactive
    end
  end

  def truthy?(arg)
    ActiveModel::Type::Boolean.new.cast(arg)
  end
end
