require 'rails_helper'
RSpec::Matchers.define_negated_matcher :exclude, :include

RSpec.describe 'tasks', type: :system do
  include LoginSupport
  before { driven_by :rack_test }

  describe 'index' do
    let(:user) { FactoryBot.create(:user) }

    before do
      create_list(:task, 3, user_id: user.id)
      sign_in_as user
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

    context 'when valid priority' do
      it 'order by asc' do
        ordered_tasks_title_by_asc = Task.all.order(priority: :asc).pluck(:title)
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:priority)}')]/a[1]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq ordered_tasks_title_by_asc
      end

      it 'order by desc' do
        ordered_tasks_title_by_desc = Task.all.order(priority: :desc).pluck(:title)
        find(:xpath, "//th[contains(.,'#{Task.human_attribute_name(:priority)}')]/a[2]").click
        titles_in_view = all('tbody tr td[1]').map(&:text)
        expect(titles_in_view).to eq ordered_tasks_title_by_desc
      end
    end

    it 'is valid click title search button' do
      reading_task = FactoryBot.create(:task, title: 'read book', user_id: user.id)
      running_task = FactoryBot.create(:task, title: 'running', user_id: user.id)
      fill_in 'title_term', with: 'read book'
      click_button 'タスク名で検索'
      title_in_view = all('tbody tr td[1]').map(&:text)
      expect(title_in_view).to include(reading_task.title).and exclude(running_task.title)
    end

    it 'is valid click status search button' do
      complete_task = FactoryBot.create(:task, status: '完了', user_id: user.id)
      working_task = FactoryBot.create(:task, status: '着手中', user_id: user.id)
      find("option[value='完了']").select_option
      click_button 'ステータスで検索'
      status_in_view = all('tbody tr td a.link_disabled').map(&:text)
      expect(status_in_view).to include(complete_task.status).and exclude(working_task.status)
    end

    it 'is valid click priority search button' do
      high_priority_task = FactoryBot.create(:task, priority: '高', user_id: user.id)
      low_priotiry_task = FactoryBot.create(:task, priority: '低', user_id: user.id)
      find("option[value='高']").select_option
      click_button '優先順位で検索'
      status_in_view = all('tbody tr td[2]').map(&:text)
      expect(status_in_view).to include(high_priority_task.priority).and exclude(low_priotiry_task.priority)
    end
  end
end
