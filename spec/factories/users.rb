FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Darth Vader #{n}" }
    sequence(:email) { |n| "ich-#{n}@dwgadf.de" }
    password 'password'
    password_confirmation 'password'
  end
end
