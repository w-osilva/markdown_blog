FactoryGirl.define do

  factory :user, class: User do
    email {Faker::Internet.email}
    password Faker::Lorem.characters(10)
    nickname Faker::Name.first_name
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    photo Faker::Avatar.image
  end

end