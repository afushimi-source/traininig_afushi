FactoryBot.define do
  now = Time.current
  factory :task do
    sequence(:title) { |n| "test#{n}" }
    sequence(:status) { '未着手' }
    sequence(:deadline_on) { |n| now.since(n.weeks) }
    description { 'test' }
    sequence(:created_at) { |n| now.since(n.days) }
    sequence(:updated_at) { |n| now.since(n.days) }
    association :user
  end
end
