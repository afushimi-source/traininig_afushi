require 'rails_helper'

RSpec.describe 'errors', type: :system do
  before { driven_by :rack_test }

  context 'when visit don\'t exist page' do
    before { visit '/test/not_exist_path' }

    it('returns 404 page') { expect(page).to have_content('404 Not Found') }

    it('returns 404 status code') { expect(page.status_code).to eq 404 }
  end

  context 'when occur unexpected system error' do
    before do
      allow_any_instance_of(UsersController).to receive(:new).and_throw(Exception)
      visit new_user_path
    end

    it('returns 500 page') { expect(page).to have_content '500 Internal Server Error' }

    it('returns 500 status code') { expect(page.status_code).to eq 500 }
  end
end
