User.create!(name: 'taro', email: 'taro@example.com', password: 'password')
3.times do |n|
  Task.create!(
    title: "test#{n}",
    user_id: User.find_by(email: 'taro@example.com').id
  )
end
