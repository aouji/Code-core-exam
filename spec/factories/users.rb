# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: 'User' do
    sequence(:email) {|n| "bob#{n}@example.com"}
    password 'aaaaaaaa' 
  end
end
