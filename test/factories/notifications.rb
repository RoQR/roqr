FactoryBot.define do
  factory :notification do
    recipient_id { "" }
    actor_id { "" }
    read_at { "2022-06-24 16:20:34" }
    action { "MyString" }
    notifiable_id { 1 }
    notifiable_type { "MyString" }
  end
end
