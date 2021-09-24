require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user, params) }
  let(:params) { { name: 'taro' } }

  shared_examples 'valid' do
    it('user') { expect(user).to be_valid }
  end

  shared_examples 'invalid' do
    it('user') { expect(user).to be_invalid }
  end

  context 'when default params' do
    it_behaves_like 'valid'
  end

  describe 'name' do
    context 'when 50 characters' do
      let(:params) { { name: 'a' * 50 } }

      it_behaves_like 'valid'
    end

    context 'when without name' do
      let(:params) { { name: nil } }

      it_behaves_like 'invalid'
    end

    context 'when 51 characters or more' do
      let(:params) { { name: 'a' * 51 } }

      it_behaves_like 'invalid'
    end
  end

  describe 'email' do
    context 'when 255 characters' do
      let(:params) { { email: "#{'a' * 251}@a.a" } }

      it_behaves_like 'valid'
    end

    context 'when without a email' do
      let(:params) { { email: nil } }

      it_behaves_like 'invalid'
    end

    context 'when 256 characters or more' do
      let(:params) { { email: "#{'a' * 252}@a.a"} }

      it_behaves_like 'invalid'
    end

    context 'when wrong format email' do
      let(:params) { { email: 'a' * 6 } }

      it_behaves_like 'invalid'
    end

    context 'when a duplicate email' do
      before do
        FactoryBot.create(:user, email: 'same@aaa.com')
        params.merge!(email: 'same@aaa.com')
      end

      it_behaves_like 'invalid'
    end
  end

  describe 'password' do
    context 'when 6 characters' do
      let(:params) { { password: 'a' * 6, password_confirmation: 'a' * 6 } }

      it_behaves_like 'valid'
    end

    context 'when without password' do
      let(:params) { { password: nil, password_confirmation: nil } }

      it_behaves_like 'invalid'
    end

    context 'when 5 characters or less' do
      let(:params) { { password: 'a' * 5, password_confirmation: 'a' * 5 } }

      it_behaves_like 'invalid'
    end

    context 'when password is not same password_confirmation' do
      let(:params) { { password: 'a' * 5, password_confirmation: 'b' * 5 } }

      it_behaves_like 'invalid'
    end
  end
end
