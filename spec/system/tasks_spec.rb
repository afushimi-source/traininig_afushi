require 'rails_helper'
RSpec::Matchers.define_negated_matcher :exclude, :include

RSpec.describe 'tasks', type: :system do
  before { driven_by :rack_test }

  describe 'index' do
    before do
      create_list(:task, 3)
      visit tasks_path
    end

    it 'is valid default order' do
      ordered_tasks_title = Task.order(created_at: :desc).pluck(:title)
      titles_in_view = all('tbody tr td[1]').map(&:text)
      expect(titles_in_view).to eq ordered_tasks_title
    end

    context 'when valid deadline_on' do
      it 'order by asc' do
        ordered_tasks_title_by_asc = Task.order(deadline_on: :asc).pluck(:title)
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:deadline_on)}')]/a[1]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq ordered_tasks_title_by_asc
      end

      it 'order by desc' do
        ordered_tasks_title_by_desc = Task.order(deadline_on: :desc).pluck(:title)
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:deadline_on)}')]/a[2]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq ordered_tasks_title_by_desc
      end
    end

    it 'is valid click title search button' do
      todo_task1 = FactoryBot.create(:task, title: 'aaaa')
      todo_task2 = FactoryBot.create(:task, title: 'bbbb')
      fill_in 'title_term', with: 'aaaa'
      click_button 'タスク名で検索'
      title_in_view = all('tbody tr td[1]').map(&:text)
      expect(title_in_view).to include(todo_task1.title).and exclude(todo_task2.title)
    end

    it 'is valid click status search button' do
      todo_task1 = FactoryBot.create(:task, status: '完了')
      todo_task2 = FactoryBot.create(:task, status: '着手中')
      find("option[value='完了']").select_option
      click_button 'ステータスで検索'
      status_in_view = all('tbody tr td a.link_disabled').map(&:text)
      expect(status_in_view).to include(todo_task1.status).and exclude(todo_task2.status)
    end
  end
end
