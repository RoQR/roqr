FactoryBot.define do
  factory :url_link do
    url { 'https://google.com' }
  end

  factory :link do
    sequence(:name) { |n| "Link#{n}" }
    dynamic { false }
    password { nil }
    organization
    dots_color { '#000000' }
    dots_shape { 'square' }
    corner_dots_color { '#000000' }
    corner_dots_shape { 'square' }
    corner_squares_color { '#000000' }
    corner_squares_shape { 'square' }
    background_color { '#ffffff' }

    trait :url do
      url_link
    end
  end
end
