FactoryGirl.define do
  factory :user do
    email 'mail@mail.com'
    password "password"
    password_confirmation "password"
  end
end
