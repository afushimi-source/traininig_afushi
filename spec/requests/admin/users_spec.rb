require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do
  describe 'admin/users' do
    let(:user) { FactoryBot.create(:user, name: 'taro', is_admin: true) }

    before { post login_path, params: { session: { email: user.email, password: user.password } } }

    describe 'update' do
      it 'can update normal user to admin user' do
        # 管理ユーザーが0人になる更新・削除は実行できないためユーザー作成
        normal_user = FactoryBot.create(:user, is_admin: false)
        put admin_user_path(normal_user), params: { user: { is_admin: true } }
        expect(normal_user.reload.is_admin).to eq true
      end

      it 'cannot update admin user to normal user with admin user none' do
        put admin_user_path(user), params: { user: { is_admin: false } }
        expect(user.reload.is_admin).to eq true
      end
    end

    describe 'destroy' do
      it 'can destroy admin user with other admin user exist' do
        FactoryBot.create(:user, is_admin: true)
        expect { delete admin_user_path(user) }.to change(User, :count).by(-1)
      end

      it('cannot change admin user count to zero by update') { expect { delete admin_user_path(user) }.to change(User, :count).by(0) }
    end
  end
end
