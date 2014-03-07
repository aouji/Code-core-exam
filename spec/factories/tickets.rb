# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    sequence(:title) {|n| "Title#{n}"}
    body "MyText"
    resolved false
    association :user, factory: :user
  end

end
