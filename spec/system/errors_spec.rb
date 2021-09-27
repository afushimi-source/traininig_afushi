require 'rails_helper'

RSpec.describe 'errors', type: :system do
  context 'when visit don\'t exist page' do
    it 'return 404 page' do
      visit '/not/exist/path'

      expect(page).to have_content('404 Not Found')
    end
  end
end
