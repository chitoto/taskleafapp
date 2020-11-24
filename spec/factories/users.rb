FactoryBot.define do
  factory :user, class: User do
    name { 'aaa' }
    email { 'aaa@aaa.com' }
    password { '123456' }
    password_confirmation { '123456' }
    admin { true }
  end

  factory :user2, class: User do
    name { 'bbb' }
    email { 'bbb@bbb.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end

  factory :user3, class: User do
    name { 'ccc' }
    email { 'ccc@ccc.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end

end
