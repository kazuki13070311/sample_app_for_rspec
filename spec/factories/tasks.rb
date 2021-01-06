FactoryBot.define do
  factory :task do
    title {'テスト'}
    content {'サンプル'}
    status {1}
    user
  end
end
