FactoryGirl.define do

  factory :user, class: User do
    email {Faker::Internet.email}
    nickname Faker::Name.name
    password Faker::Lorem.characters(10)
  end

end