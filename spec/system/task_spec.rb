require 'rails_helper'

RSpec.describe 'Index', type: :system do
  it 'test' do
    visit tasks_path
    expect(page).to have_content 'タスク一覧'
  end
end
