require 'rails_helper'

RSpec.describe 'tasks', type: :system do
  include LoginSupport
  before { driven_by :rack_test }

  describe 'login' do
    before do
      user = FactoryBot.create(:user)
      sign_in_as user
    end

    it('is valid flash message after login') { expect(page).to have_content 'ログインに成功しました' }

    it('is valid page after login') { expect(page).to have_current_path tasks_path, ignore_query: true }
  end

  describe 'logout' do
    before do
      user = FactoryBot.create(:user)
      sign_in_as user
      visit tasks_path
      click_link 'Logout'
    end

    it('is valid flash message after logout') { expect(page).to have_content 'ログアウトに成功しました' }

    it('is valid page after logout') { expect(page).to have_current_path root_path, ignore_query: true }
  end
end
