require 'rails_helper'

RSpec.describe 'users', type: :request do
  let(:user) { FactoryBot.create(:user, name: 'taro') }
  before { post login_path, params: { session: { email: user.email, password: user.password } } }

  describe 'update' do
    it 'can change user\'s name' do
      put user_path(user), params: { user: { name: 'test' } }
      expect(user.reload.name).to eq 'test'
      p user.errors
    end

    it 'cantnot change user\'s admin' do
      put user_path(user), params: { user: { admin: true } }
      expect(user.reload.admin).to eq false
    end

    it 'cannot modify by not correct user'
    # 専用のエラー
  end

  describe 'destroy' do
    it 'cannot modify by not correct user'
    # 専用のエラー
  end
end
