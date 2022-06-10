class AlertComponentPreview < ViewComponent::Preview
  def success
    render(AlertComponent.new(status: 'success').with_content('Success'))
  end

  def info
    render(AlertComponent.new(status: 'info').with_content('Info'))
  end

  def warn
    render(AlertComponent.new(status: 'warn').with_content('Warn'))
  end

  def error
    render(AlertComponent.new(status: 'error').with_content('Error'))
  end
end
