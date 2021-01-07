FactoryBot.define do
  factory :task do
    sequence(:title, "title_1")
    content {'サンプル'}
    status {1}
    user
  end
end
