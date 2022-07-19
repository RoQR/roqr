class Rack::Attack
  throttle('req/ip', limit: 5, period: 1.seconds) do |req|
    req.ip
  end
end
