require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by :rack_test
    driven_by(:selenium_chrome_headless)
  end

  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit sign_up_path
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        login(user)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Login successful'
      end
    end
    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit sign_up_path
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        visit login_path
        fill_in 'Email', with: nil
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login failed'
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login(user)
        click_link 'Logout'
        expect(current_path).to eq root_path
        expect(page).to have_content 'Logged out'
      end
    end
  end
end
