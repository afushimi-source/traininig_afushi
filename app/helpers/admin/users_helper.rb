module Admin::UsersHelper
  def admin_check_box(user)
    if user.is_admin?
      diplay_text = '☑️'
      admin_attribute = false
    else
      diplay_text = '□'
      admin_attribute = true
    end
    button_to diplay_text, admin_user_path(user.id, params: { user: { is_admin: admin_attribute } }), method: :put, class: 'btn btn-secondary'
  end
end
