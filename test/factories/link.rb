FactoryBot.define do
  factory :url_link do
    url { 'https://google.com' }
  end

  factory :link do
    sequence(:name) { |n| "Link#{n}" }
    dynamic { false }
    password { nil }
    organization
    color { '#000000' }
    fill { '#ffffff' }

    trait :url do
      url_link
    end
  end
end
