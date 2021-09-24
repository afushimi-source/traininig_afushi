FactoryBot.define do
  factory :label_map do
    association :task
    association :label
  end
end
