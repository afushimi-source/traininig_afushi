require 'rails_helper'

RSpec.describe 'sessions', type: :system do
  include LoginSupport
  before do
    driven_by :rack_test
    user = FactoryBot.create(:user)
    sign_in_as user
  end

  describe 'login' do
    it('is valid flash message after login') { expect(page).to have_content 'ログインに成功しました' }

    it('is valid page after login') { expect(page).to have_current_path tasks_path, ignore_query: true }
  end

  describe 'logout' do
    before do
      visit tasks_path
      click_link 'ログアウト'
    end

    it('is valid flash message after logout') { expect(page).to have_content 'ログアウトに成功しました' }

    it('is valid page after logout') { expect(page).to have_current_path root_path, ignore_query: true }
  end
end
