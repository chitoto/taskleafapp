User.create!( name: "adminseed", email: "admin@seed.com",
    password: '123456',password_confirmation: '123456', admin: true,)

10.times do |n|
  User.create!(
    name: "seed#{n + 1}",
    email: "seed#{n + 1}@test.com",
    password: '123456',password_confirmation: '123456', admin: rand(2).zero?,
    )
end

10.times do |n|
  Label.create!(
    name: "ラベル#{n + 1}",
    )
end

User.all.each do |user|
  10.times do |n|
    user.tasks.create!(
      task_title: "タイトル#{n + 1}",
      task_description: "#{user[:name]}テキストテキストテキストテキスト",
      status: rand(0..2),
      priority: rand(0..2),
      label_ids: [rand(1..3), rand(4..6), rand(7..10)]
    )
  end
end
