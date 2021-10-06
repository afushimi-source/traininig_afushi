require 'rails_helper'
RSpec::Matchers.define_negated_matcher :exclude, :include
FactoryBot.use_parent_strategy = false

RSpec.describe Task, type: :model do
  it 'is valid with a title and description' do
    task = FactoryBot.build(:task)
    expect(task).to be_valid
  end

  describe 'title' do
    context 'when valid' do
      it '30 characters' do
        task = FactoryBot.build(:task, title: 'a' * 30)
        expect(task).to be_valid
      end
    end

    context 'when invalid' do
      it 'without a title' do
        task = FactoryBot.build(:task, title: nil)
        expect(task).to be_invalid
      end

      it '31 characters or more' do
        task = FactoryBot.build(:task, title: 'a' * 31)
        expect(task).to be_invalid
      end
    end
  end

  describe 'description' do
    context 'when valid' do
      it '600 characters' do
        task = FactoryBot.build(:task, description: 'a' * 600)
        expect(task).to be_valid
      end
    end

    context 'when invalid' do
      it '601 characters or more' do
        task = FactoryBot.build(:task, description: 'a' * 601)
        expect(task).to be_invalid
      end
    end
  end

  describe 'search for a term' do
    let(:todo_task) { FactoryBot.create(:task, title: 'aaa', status: '未着手') }
    let(:working_task) { FactoryBot.create(:task, title: 'bbb', status: '着手中') }
    let(:finished_task) { FactoryBot.create(:task, title: 'ccc', status: '完了') }
    let(:high_priority_task) { FactoryBot.create(:task, priority: '高') }
    let(:low_priority_task) { FactoryBot.create(:task, priority: '低') }

    it('is valid search for a title term') { expect(described_class.search(title_term: 'aaa')).to include(todo_task).and exclude(working_task, finished_task) }

    it('is valid search for a status term') { expect(described_class.search(status_term: '完了')).to include(finished_task).and exclude(todo_task, working_task) }

    it('is valid search for a priority term') { expect(described_class.search(priority_term: '高')).to include(high_priority_task).and exclude(low_priority_task) }

    it('return an empty collection') { expect(described_class.search(title_term: 'zzz')).to be_empty }

    it 'return a high priority and finished task' do
      finished_and_high_priority_task = FactoryBot.create(:task, status: '完了', priority: '高')
      expect(described_class.search(status_term: '完了', priority_term: '高')).to include(finished_and_high_priority_task).and exclude(finished_task, high_priority_task)
    end

    it 'is valid search for a label term' do
      rails_task = FactoryBot.create(:task, :with_labels, label_names: ['rails'])
      laravel_task = FactoryBot.create(:task, :with_labels, label_names: ['larabel'])
      expect(described_class.search(label_term: 'rails')).to include(rails_task).and exclude(laravel_task)
    end
  end
end
