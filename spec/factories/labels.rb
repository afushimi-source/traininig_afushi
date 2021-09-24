FactoryBot.define do
  factory :label do
    sequence(:name) { |n| "lable#{n}" }
  end
end
