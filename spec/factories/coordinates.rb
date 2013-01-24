FactoryGirl.define do
  factory :coordinate do
    sequence(:lat) { |n| 52 + (n/10.0) }
    sequence(:lng) { |n| 6 + (n/10.0) }
  end
end
