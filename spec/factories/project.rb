FactoryBot.define do
  factory :project do
    title { "Test Project" }
    description { "test description" }
    status { "open" }
  end
end
