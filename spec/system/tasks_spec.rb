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
  end
end
