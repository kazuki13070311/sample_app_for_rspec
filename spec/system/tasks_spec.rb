require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'タスク新規作成ページにアクセス' do
        it 'タスク新規作成画面へのアクセスが失敗する' do
          visit new_task_path
          expect(current_path).to eq login_path
          expect(page).to have_content 'Login required'
        end
      end

      context 'タスクの編集ページにアクセス' do
        it 'タスク編集画面へのアクセスが失敗する' do
          visit edit_task_path(task)
          expect(current_path).to eq login_path
          expect(page).to have_content 'Login required'
        end
      end
    end
  end

  describe 'ログイン後' do

    before do
      login(user)
    end

    describe 'タスク新規作成' do
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成が成功する' do
          visit new_task_path(user)
          fill_in 'Title' , with: 'テストタイトル'
          fill_in 'Content', with: 'サンプル'
          click_button 'Create'
          expect(current_path).to eq task_path(user)
          expect(page).to have_content 'Task was successfully created.'
        end
      end
    end

    describe 'タスク編集' do
      context 'フォームの入力値が正常' do
        it 'タスクの編集が成功する' do
          visit new_task_path(user)
          fill_in 'Title' , with: 'テストタイトル'
          fill_in 'Content', with: 'サンプル'
          click_button 'Create'
          click_link 'Edit'
          fill_in 'Title' , with: 'テストタイトル1'
          fill_in 'Content', with: 'サンプル1'
          click_button 'Update Task'
          expect(current_path).to eq task_path(user)
          expect(page).to have_content 'Task was successfully updated.'
        end
      end
    end

    describe 'タスク削除' do
      it 'タスクの削除が成功する' do
        visit new_task_path(user)
        fill_in 'Title' , with: 'テストタイトル2'
        fill_in 'Content', with: 'サンプル2'
        click_button 'Create'
        click_link 'Task list'
        click_link 'Destroy'
        expect {
          page.accept_confirm "Are you sure?"
          expect(page).to have_content "Task was successfully destroyed."
        }.to change { Task.count }.by(-1)
        expect(current_path).to eq tasks_path
      end
    end

    describe '他ユーザーのタスク編集ページにアクセス' do
      it '編集ページへのアクセスが失敗する' do
        visit root_url
        visit edit_task_path(task)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Forbidden access.'
      end
    end
  end
end
