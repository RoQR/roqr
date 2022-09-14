FactoryBot.define do
  factory :style do
    name { 'MyStyle' }
    organization
    dots_color { '#000000' }
    dots_shape { 'square' }
    corner_dots_color { '#000000' }
    corner_dots_shape { 'square' }
    corner_squares_color { '#000000' }
    corner_squares_shape { 'square' }
    background_color { '#ffffff' }
  end
end
