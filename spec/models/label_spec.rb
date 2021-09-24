require 'rails_helper'

RSpec.describe Label, type: :model do
  let(:label) { FactoryBot.build(:label, name: name) }
  let(:name) { 'test' }

  shared_examples 'valid' do
    it('label') { expect(label).to be_valid }
  end

  shared_examples 'invalid' do
    it('label') { expect(label).to be_invalid }
  end

  context 'when default name' do
    it_behaves_like 'valid'
  end

  context 'when 15 characters' do
    let(:name) { 'a' * 15 }

    it_behaves_like 'valid'
  end

  context 'when 16 characters or more' do
    let(:name) { 'a' * 16 }

    it_behaves_like 'invalid'
  end

  context 'when without name' do
    let(:name) { nil }

    it_behaves_like 'invalid'
  end

  context 'when same name is exist' do
    before { FactoryBot.create(:label, name: 'same') }
    let(:name) { 'same' }

    it_behaves_like 'invalid'
  end
end
