require 'rails_helper'

RSpec.describe Task, type: :system do
  describe 'validation' do
    it 'is valid with all attributes' do
      task = create(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'is invalid without title' do
      task_without_title = build(:task,title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]). to include("can't be blank")
    end

    it 'is invalid without status' do
      task_without_status = build(:task,status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]). to include("can't be blank")
    end

    it 'is invalid with a duplicate title' do
      task = create(:task)
      task_with_duplicated_title = build(:task, title: task.title)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]). to include("has already been taken")
    end

    it 'is valid with another title' do
      task = create(:task)
      task_with_another_title = build(:task,title: 'テスト1')
      expect(task_with_another_title).to be_valid
      expect(task_with_another_title.errors).to be_empty
    end
  end
end
