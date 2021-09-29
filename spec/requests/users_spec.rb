require 'rails_helper'

RSpec.describe 'users', type: :request do
  let(:user) { FactoryBot.create(:user, name: 'taro') }

  before { post login_path, params: { session: { email: user.email, password: user.password } } }

  describe 'update' do
    it 'can change user\'s name' do
      put user_path(user), params: { user: { name: 'test' } }
      expect(user.reload.name).to eq 'test'
    end

    it 'cantnot change user\'s admin' do
      put user_path(user), params: { user: { is_admin: true } }
      expect(user.reload.is_admin).to eq false
    end

    it 'cannot update by not correct user' do
      other_user = FactoryBot.create(:user)
      put user_path(other_user), params: { user: { name: 'test' } }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'destroy' do
    it 'deleted user, user\'s task also deleted' do
      create_list(:task, 5, user_id: user.id)
      delete user_path(user)
      expect(Task.count).to eq 0
    end

    it 'cannot destroy by not correct user' do
      other_user = FactoryBot.create(:user)
      delete user_path(other_user)
      expect(response).to have_http_status(:forbidden)
    end
  end
end
