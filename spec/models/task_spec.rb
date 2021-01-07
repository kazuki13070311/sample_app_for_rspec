require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      task = create(:task)
      expect(task).to be_valid
    end

    it 'is invalid without title' do
      task_without_title = build(:task,title: nil)
      task_without_title.valid?
      expect(task_without_title.errors[:title]). to include("can't be blank")
    end

    it 'is invalid without status' do
      task_without_status = build(:task,status: nil)
      task_without_status.valid?
      expect(task_without_status.errors[:status]). to include("can't be blank")
    end

    it 'is invalid with a duplicate title' do
      task = create(:task)
      task_duplicate_title = build(:task, title: task.title)
      task_duplicate_title.valid?
      expect(task_duplicate_title.errors[:title]). to include("has already been taken")
    end

    it 'is valid with another title' do
      task_another_title1 = create(:task)
      task_another_title2 = build(:task,title: 'テスト1')
      expect(task_another_title2).to be_valid
    end
  end
end
