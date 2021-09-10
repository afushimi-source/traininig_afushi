require 'rails_helper'

RSpec.describe 'tasks', type: :system do
  before { driven_by :rack_test }

  describe 'index' do
    before do
      create_list(:task, 3)
      visit tasks_path
    end

    it 'is valid default order' do
      titles_in_view = all('tbody tr td[1]').map(&:text)
      expect(titles_in_view).to eq Task.all.order(created_at: :desc).pluck(:title)
    end

    context 'when valid deadline_on' do
      it 'order by asc' do
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:deadline_on)}')]/a[1]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq Task.all.order(deadline_on: :asc).pluck(:title)
      end

      it 'order by desc' do
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:deadline_on)}')]/a[2]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq Task.all.order(deadline_on: :desc).pluck(:title)
      end
    end

    it 'is valid search function button' do
      search_term = '完了'
      task1 = FactoryBot.create(:task, status: search_term)
      task2 = FactoryBot.create(:task, status: '着手中')
      fill_in 'term', with: search_term
      click_button '検索'
      status_in_view = all('tbody tr td a.link_disabled').map(&:text)
      expect(status_in_view).to include(task1.status)
      expect(status_in_view).not_to include(task2.status)
    end
  end
end
