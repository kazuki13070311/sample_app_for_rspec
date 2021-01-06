FactoryBot.define do
  factory :user do
    email {'task@gmail.com'}
    password {'password'}
    password_confirmation {'password'}
  end
end
