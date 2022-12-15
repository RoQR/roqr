# frozen_string_literal: true

FactoryBot.define do
  factory :url_link do
    url { "https://google.com" }
  end

  factory :contact_link do
    first_name { "Jane" }
    last_name { "Doe" }
  end

  factory :link do
    sequence(:name) { |n| "Link#{n}" }
    dynamic { false }
    password { nil }
    organization
    custom_domain
    dots_color { "#000000" }
    dots_shape { "square" }
    corner_dots_color { "#000000" }
    corner_dots_shape { "square" }
    corner_squares_color { "#000000" }
    corner_squares_shape { "square" }
    background_color { "#ffffff" }

    trait :url do
      url_link
    end

    trait :contact do
      contact_link
    end
  end
end
