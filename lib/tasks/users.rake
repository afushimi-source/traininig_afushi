namespace :users do
  desc 'user_id: nilの既存レコードにseedで作成したユーザーを関連づける'
  task accociate_user_id: :environment do
    tasks = Task.where(user_id: nil)
    user = User.find_by(name: 'taro', email: 'taro@example.com')
    tasks.update(user_id: user.id)
  end
end
