require 'rails_helper'

RSpec.describe 'admin/users', type: :system do
  before { driven_by :rack_test }
  describe 'admin/users/index' do
    let(:user) { FactoryBot.create(:user, name: 'test', admin: true) }

    before do
      sign_in_as(user)
      create_list(:task, 5, user_id: user.id)
      visit admin_users_path
    end

    it 'can see user\'s task count' do
      view_count = find(:xpath, "//tr[contains(.,'#{user.name}')]/td[3]").text.to_i
      expect(view_count).to eq user.tasks.count
    end

    it 'cannot access not admin user' do
      # 専用のエラーページへ
    end
  end
end
