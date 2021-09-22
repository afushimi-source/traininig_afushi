require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valud with a name, email, password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe 'name' do
    context 'when valid' do
      it '50 characters' do
        user = FactoryBot.build(:user, name: 'a' * 50)
        expect(user).to be_valid
      end
    end

    context 'when invalid' do
      it 'without a name' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).to be_invalid
      end

      it '51 characters or more' do
        user = FactoryBot.build(:user, name: 'a' * 51)
        expect(user).to be_invalid
      end
    end

    describe 'email' do
      context 'when valid' do
        it '255 characters' do
          user = FactoryBot.build(:user, email: "#{'a' * 251}@a.a")
          expect(user).to be_valid
        end
      end

      context 'when invalid' do
        it 'without a email' do
          user = FactoryBot.build(:user, email: nil)
          expect(user).to be_invalid
        end

        it '256 characters or more' do
          user = FactoryBot.build(:user, email: "#{'a' * 251}@a.a")
          expect(user).to be_invalid
        end

        it 'wrong format email' do
          user = FactoryBot.build(:user, email: 'a' * 6)
          expect(user).to be_invalid
        end

        it 'a duplicate email' do
          FactoryBot.create(:user, email: 'same@aaa.com')
          user = FactoryBot.build(:user, email: 'same@aaa.com')
          expect(user).to be_invalid
        end
      end
    end

    describe 'password' do
      context 'when valid' do
        it '6 characters' do
          user = FactoryBot.build(:user, password: 'a' * 6, password_confirmation: 'a' * 6)
          expect(user).to be_valid
        end
      end

      context 'when invalid' do
        it 'without a password' do
          user = FactoryBot.build(:user, password: nil, password_confirmation: nil)
          expect(user).to be_invalid
        end

        it '5 characters or less' do
          user = FactoryBot.build(:user, password: 'a' * 5, password_confirmation: 'a' * 5)
          expect(user).to be_invalid
        end
      end
    end
  end
end
