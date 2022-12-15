FactoryBot.define do
  factory :custom_domain do
    url { "qr.example.com" }
    organization
    status { "Submitted" }
  end
end
