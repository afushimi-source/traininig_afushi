module UsersHelper
  def user_type(user)
    user.admin? ? '管理者' : '一般'
  end
end
