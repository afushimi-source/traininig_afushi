module UsersHelper
  def user_type(user)
    user.is_admin? ? '管理者' : '一般'
  end

  def toggle_admin(user)
    if user.is_admin?
      diplay_text = '一般ユーザーへ'
      admin_attribute = false
    else
      diplay_text = '管理者ユーザへ'
      admin_attribute = true
    end
    link_to diplay_text, admin_user_path(user.id, params: { user: { is_admin: admin_attribute } }), method: :put
  end

  def display_admin(user)
    user.is_admin? ? '管理者' : '一般'
  end
end
