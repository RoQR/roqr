FactoryBot.define do
  factory :style do
    name { 'MyStyle' }
    organization
    color { '#ffffff' }
    fill { '#000000' }
  end
end
