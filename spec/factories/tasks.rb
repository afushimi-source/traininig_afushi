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

    transient do
      label_names  { nil }
    end

    trait :with_labels do
      after(:build) do |task, evaluator|
        if evaluator.label_names.nil?
          create(:label_map, task: task, label: create(:label))
        else
          evaluator.label_names.each { |name| create(:label_map, task: task, label: create(:label, name: name)) }
        end
      end
    end
  end
end
