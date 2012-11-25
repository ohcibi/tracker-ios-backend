FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "ich-#{n}@dwgadf.de" }
    password 'password'
    password_confirmation 'password'
  end
end
