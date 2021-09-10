require 'rails_helper'

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
    let!(:task1) { FactoryBot.create(:task, title: 'aaa', status: '未着手') }
    let!(:task2) { FactoryBot.create(:task, title: 'bbb', status: '着手中') }
    let!(:task3) { FactoryBot.create(:task, title: 'ccc', status: '完了') }

    context 'when search for a title term' do
      it('returns valid records') { expect(described_class.search('aaa')).to include(task1) }
      it('not returns invalid records') { expect(described_class.search('aaa')).not_to include(task2, task3) }
    end

    context 'when search for a status term' do
      it('return valid records') { expect(described_class.search('完了')).to include(task3) }
      it('not return invalid records') { expect(described_class.search('完了')).not_to include(task1, task2) }
    end

    context 'when no match is found' do
      it('return an empty collection') { expect(described_class.search('zzz')).to be_empty }
    end
  end
end
