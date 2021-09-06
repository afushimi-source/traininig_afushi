require 'rails_helper'

RSpec.describe 'tasks', type: :system do
  before { driven_by :rack_test }

  describe 'index' do
    before { create_list(:task, 3); visit tasks_path }

    it 'is valid default order' do
      ordered_tasks_title = Task.all.order(created_at: :desc).pluck(:title)
      titles_in_view = all('tbody tr td[1]').map(&:text)
      expect(titles_in_view).to eq ordered_tasks_title
    end

    context 'when valid deadline' do
      it 'order by asc' do
        ordered_tasks_title_by_asc = Task.all.order(deadline: :asc).pluck(:title)
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:deadline)}')]/a[1]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq ordered_tasks_title_by_asc
      end

      it 'order by desc' do
        ordered_tasks_title_by_desc = Task.all.order(deadline: :desc).pluck(:title)
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:deadline)}')]/a[2]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq ordered_tasks_title_by_desc
      end
    end
  end
end
