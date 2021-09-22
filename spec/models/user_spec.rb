require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valud with a name, email, password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe 'name' do
    let(:user) { FactoryBot.build(:user, name: name) }

    context 'when valid' do
      let(:name) { 'a' * 50 }
      it('50 characters') { expect(user).to be_valid }
    end

    context 'when invalid' do
      let(:name) { nil }
      it('without a name') { expect(user).to be_invalid }

      let(:name) { 'a' * 51 }
      it('51 characters or more') { expect(user).to be_invalid }
    end
  end

  describe 'email' do
    let(:user) { FactoryBot.build(:user, email: email) }

    context 'when valid' do
      let(:email) { "#{'a' * 251}@a.a" }
      it('255 characters') { expect(user).to be_valid }
    end

    context 'when invalid' do
      let(:email) { nil }
      it('without a email') { expect(user).to be_invalid }

      let(:email) { "#{'a' * 252}@a.a" }
      it('256 characters or more') { expect(user).to be_invalid }

      let(:email) { 'a' * 6 }
      it('wrong format email') { expect(user).to be_invalid }

      it 'a duplicate email' do
        FactoryBot.create(:user, email: 'same@aaa.com')
        user = FactoryBot.build(:user, email: 'same@aaa.com')
        expect(user).to be_invalid
      end
    end
  end

  describe 'password' do
    let(:user) { FactoryBot.build(:user, password: password, password_confirmation: password_confirmation) }
    context 'when valid' do
      let(:password) { 'a' * 6 }
      let(:password_confirmation) { 'a' * 6 }
      it('6 characters') { expect(user).to be_valid }
    end

    context 'when invalid' do
      let(:password) { nil }
      let(:password_confirmation) { nil }
      it('without a password') { expect(user).to be_invalid }

      let(:password) { 'a' * 5 }
      let(:password_confirmation) { 'a' * 5 }
      it('5 characters or less') { expect(user).to be_invalid }
    end
  end
end
