FactoryBot.define do
  factory :project_activity do
    association :project
    association :user

    activity_type { 'comment' }
    comment       { "Sample comment" }

    trait :status_change do
      activity_type { 'status_change' }
      old_status   { "inactive" }
      new_status   { "active" }
    end
  end
end
