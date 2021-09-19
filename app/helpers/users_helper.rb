module UsersHelper
  def user_type(user)
    user.admin? ? '管理者' : '一般'
  end

  def toggle_admin(user)
    if user.admin?
      diplay_text = '一般ユーザーへ'
      admin_attribute = false
    else
      diplay_text = '管理者ユーザへ'
      admin_attribute = true
    end
    link_to diplay_text, user_path(user.id, params: { user: { admin: admin_attribute } }), method: :put
  end
end
