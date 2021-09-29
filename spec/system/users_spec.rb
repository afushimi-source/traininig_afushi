require 'rails_helper'

RSpec.describe 'users', type: :system do
  before { driven_by :rack_test }

  describe 'signup' do
    before { visit signup_path }

    it 'is valid with user_name, email, password, password_cofirmination' do
      fill_in 'user_name', with: 'taro'
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '送信'
      expect(page).to have_content 'ユーザー登録に成功しました'
    end

    it 'is invalid without user name' do
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '送信'
      expect(page).to have_content '名前を入力してください'
    end

    it 'is invalid same email as other email' do
      FactoryBot.create(:user, email: 'test@example.com')
      fill_in 'user_name', with: 'taro'
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '送信'
      expect(page).to have_content 'メールアドレスはすでに存在します'
    end
  end

  describe 'admin/index' do
    let(:user) { FactoryBot.create(:user, name: 'test') }

    before do
      create_list(:task, 5, user_id: user.id)
      visit admin_users_path
    end

    it('deleted user, user\'s task also deleted') { expect { click_link '削除' }.to change(Task, :count).by(-5) }

    it 'can see user\'s task count' do
      view_count = find(:xpath, "//tr[contains(.,'#{user.name}')]/td[3]").text.to_i
      expect(view_count).to eq user.tasks.count
    end
  end
end
