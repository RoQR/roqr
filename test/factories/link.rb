FactoryBot.define do
  factory :url_link do
    url { 'https://google.com' }
  end

  factory :link do
    name { 'Link' }
    dynamic { false }
    password { nil }
    organization

    trait :url do
      url_link
    end
  end
end
