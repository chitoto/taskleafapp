require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:user2)
    FactoryBot.create(:user3)
    visit tasks_path
  end
  describe 'ユーザ登録機能' do
    context 'アカウント作成する' do
      it '作成したユーザーが表示される' do
      visit new_user_path
      fill_in '名前', with: 'なまえ'
      fill_in 'メールアドレス', with: 'xxx@xxx.com'
      fill_in 'パスワード', with: '123456'
      fill_in '確認用パスワード', with: '123456'
      click_on 'Create my account'
      expect(page).to have_content 'なまえ'
      expect(page).to have_content 'Profile'
      end
    end
  end
  describe 'ログインroutes確認' do
    context 'ログインしていない場合' do
      it 'ログイン画面が表示される' do
      visit root_path
      expect(page).to have_content 'ログインが必要です'
      end
    end
     context 'ログインする場合' do
       it '自分のプロフィールが表示される' do
         fill_in 'Email', with: 'aaa@aaa.com'
         fill_in 'Password', with: '123456'
         click_on 'Log in'
         expect(page).to have_content 'ログインしました'
         expect(page).to have_content 'aaa@aaa.com'
       end
     end
   end
   describe 'セッション機能' do
     before do
       fill_in 'Email', with: 'bbb@bbb.com'
       fill_in 'Password', with: '123456'
       click_on 'Log in'
       visit root_path
     end
     context 'ログインできる場合' do
       it '該当の内容が表示される' do
         click_on 'Logout'
         fill_in 'Email', with: 'aaa@aaa.com'
         fill_in 'Password', with: '123456'
         click_on 'Log in'
         expect(page).to have_content 'ログインしました'
       end
     end
     context '自分の詳細画面' do
       it '自分の情報が表示される' do
         click_on 'Logout'
         click_on 'Login'
         fill_in 'Email', with: 'aaa@aaa.com'
         fill_in 'Password', with: '123456'
         click_on 'Log in'
         click_on 'Profile'
         expect(page).to have_content 'aaa'
         expect(page).to have_content 'aaa@aaa.com'
       end
     end
     context '他人の詳細画面に飛べない' do
       it '該当の内容が表示される' do
         visit user_path(1)
         expect(page).to have_content '他ユーザー情報は閲覧できません！'
         expect(page).to have_content 'タスク一覧'
       end
     end
     context 'ログアウトができる' do
       it '該当の内容が表示される' do
         click_on 'Logout'
         expect(page).to have_content 'ログアウトしました'
       end
     end
     context '一般ユーザーは管理画面にアクセスできない' do
       it '該当の内容が表示される' do
         visit admin_users_path
         expect(page).to have_content '管理者以外はアクセスできません！'
       end
     end
  end
  describe 'admin一覧表示機能' do
    before do
      fill_in 'Email', with: 'aaa@aaa.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit admin_users_path
    end
    context '管理画面にアクセスできる' do
      it '作成済みのユーザー一覧が表示される' do
        click_on '管理者画面'
        expect(page).to have_content 'ユーザー一覧'
      end
    end
    context '管理ユーザはユーザの新規登録ができる' do
      it '新しいユーザーが一覧に表示される' do
        visit new_admin_user_path
        fill_in '名前', with: 'なまえ'
        fill_in 'メールアドレス', with: 'xxx@xxx.com'
        fill_in 'パスワード', with: '123456'
        fill_in '確認用パスワード', with: '123456'
        click_on '登録する'
        expect(page).to have_content 'xxx@xxx.com'
      end
    end
    context '管理ユーザはユーザの詳細画面にアクセスできる' do
      it 'ユーザの詳細画面が表示される' do
        user = FactoryBot.create(:user, email: 'syousai@xxx.com')
        visit admin_user_path(user)
        expect(page).to have_content 'syousai@xxx.com'
      end
    end
    context '管理ユーザはユーザの編集画面からユーザを編集できる' do
      it '編集内容が表示される' do
        user = FactoryBot.create(:user, email: 'syousai@xxx.com')
        visit edit_admin_user_path(user)
        fill_in '名前', with: 'なまえ'
        fill_in 'メールアドレス', with: 'xxx@xxx.com'
        fill_in 'パスワード', with: '123456'
        fill_in '確認用パスワード', with: '123456'
        click_on '更新する'
        expect(page).to have_content 'なまえ'
        expect(page).to have_content 'xxx@xxx.com'
      end
    end
    context '管理ユーザはユーザの削除をできる' do
      it '削除したユーザーが表示されない' do
        user = FactoryBot.create(:user, email: 'destroy@xxx.com')
        visit admin_users_path
        expect(page).to have_content 'destroy@xxx.com'
        user.destroy
        visit admin_users_path
        expect(page).not_to have_content 'destroy@xxx.com'
      end
    end
  end

end
