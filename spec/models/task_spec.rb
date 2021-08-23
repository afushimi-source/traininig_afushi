require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a title and description" do
    task = FactoryBot.build(:task)
    expect(task).to be_valid
  end

  it "is invalid without a title" do
    task = FactoryBot.build(:task, title: nil)
    task.valid?
    expect(task.errors[:title].join('')).to include("入力してください")
  end

  it "is invalid with a title of 31 characters or more" do
    task = FactoryBot.build(:task, title: "a" * 31)
    task.valid?
    expect(task.errors[:title].join('')).to include("30文字以内で入力してください")
  end

  it "is invalid with a description of 601 characters or more" do
    task = FactoryBot.build(:task, description: "a" * 601)
    task.valid?
    expect(task.errors[:description].join('')).to include("600文字以内で入力してください")
  end
end
