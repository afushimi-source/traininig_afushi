FactoryBot.define do
  now = Time.current
  factory :task do
    sequence(:title) { |n| "test#{n}" }
    sequence(:deadline) { |n| now.since(n.weeks) }
    sequence(:status) { '未着手' }
    description { 'test' }
    sequence(:created_at) { |n| now.since(n.days) }
    sequence(:updated_at) { |n| now.since(n.days) }
  end
end
