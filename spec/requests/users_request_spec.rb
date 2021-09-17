require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user)}
  before { sign_in_as user }

  it 'can update name' do
    user_params = FactoryBot.attributes_for(:user, name: 'aaa')
    patch "/users/#{user.id}", params: { id: user.id, user: user_params }
    expect(user.reload.name).to eq "aaa"
  end

  it 'cannot update admin' do
    user_params = FactoryBot.attributes_for(:user, admin: true)
    patch "/users/#{user.id}", params: { id: user.id, user: user_params }
    expect(user.reload.admin).to eq false
  end
end
