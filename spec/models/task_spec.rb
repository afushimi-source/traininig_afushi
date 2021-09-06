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

  describe 'search title or status for a term' do
    before do

    end

    context 'when a match is found' do
      it 'returns tasks that match the search term' do

      end
    end

    context 'when no matche is found' do
      it 'return an empty collection' do

      end
    end
  end
end
