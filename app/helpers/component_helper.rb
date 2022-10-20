module ComponentHelper
  mattr_accessor :fallback_raises, default: true

  InvalidValueError = Class.new(StandardError)

  def fetch_or_fallback(allowed_values, given_value, fallback = nil)
    if allowed_values.include?(given_value)
      given_value
    else
      if fallback_raises && ENV['RAILS_ENV'] != 'production' && ENV['STORYBOOK'] != 'true'
        raise InvalidValueError, <<~MSG
          fetch_or_fallback was called with an invalid value.
          Expected one of: #{allowed_values.inspect}
          Got: #{given_value.inspect}
          This will not raise in production, but will instead fallback to: #{fallback.inspect}
        MSG
      end

      fallback
    end
  end

  def fetch_or_fallback_boolean(given_value, fallback: false)
    if [true, false].include?(given_value)
      given_value
    else
      fallback
    end
  end
end
