require 'rails_helper'

RSpec.describe 'Task', type: :system do
  before { driven_by :rack_test }

  describe 'tasks/index' do
    (0..2).each { |_n| FactoryBot.create(:task) }
    let(:title_in_db) { Task.all.order(created_at: :desc).pluck(:title) }

    it 'is valid order' do
      visit tasks_path
      title_in_view = all('tbody tr td[1]').map(&:text)
      expect(title_in_view).to eq title_in_db
    end
  end
end
