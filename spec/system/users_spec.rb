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

  describe 'other user operation' do

  end

  describe 'admin' do
    context 'when not admin user' do
      it 'is jump page to root_path after access admin_path' do
      end
    end

    context 'when admin user' do
      it 'is valid page after access admin_path' do
      end
    end
  end
end
