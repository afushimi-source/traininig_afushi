require 'rails_helper'

RSpec.describe 'tasks', type: :system do
  before { driven_by :rack_test }

  describe 'index' do
    before do
      create_list(:task, 3)
    end

    it 'is valid order' do
      ordered_tasks_title = Task.all.order(created_at: :desc).pluck(:title)
      visit tasks_path
      titles_in_view = all('tbody tr td[1]').map(&:text)
      expect(titles_in_view).to eq ordered_tasks_title
    end

    it 'is valid order after click deadline asc' do
      ordered_tasks_title_by_deadline
    end

  end
end
