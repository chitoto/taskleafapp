require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user)}
  before do
    visit new_session_path
    fill_in 'Email', with: 'aaa@aaa.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    visit tasks_path
    FactoryBot.create(:label1)
    FactoryBot.create(:label2)
    FactoryBot.create(:label3)
    FactoryBot.create(:label4)
    FactoryBot.create(:label5)
  end
  describe 'ラベル登録機能' do
    context 'ラベル作成する' do
      it '作成したラベルが表示される' do
        visit new_label_path
        fill_in 'label_name', with: '作成テスト用ラベル'
        click_on '登録する'
        expect(page).to have_content '作成テスト用ラベル'
      end
    end
  end
  describe 'ラベル一覧機能' do
    context 'ラベル一覧に表示' do
      it '該当の内容が表示される' do
        visit labels_path
        expect(page).to have_content 'ラベル1'
        expect(page).to have_content 'ラベル2'
        expect(page).to have_content 'ラベル3'
      end
    end
  end
   describe 'ラベル編集機能' do
    context 'ラベルを編集できる' do
      it '該当の内容が表示される' do
        label = FactoryBot.create(:label1, name: '編集前ラベル')
        visit edit_label_path(label.id)
        fill_in 'label_name', with: '編集テスト用ラベル'
        click_on '更新する'
        visit labels_path
        expect(page).not_to have_content '編集前ラベル'
        expect(page).to have_content '編集テスト用ラベル'
      end
    end
  end
   describe 'ラベル削除機能' do
    context 'ラベルが削除できる' do
      it '削除ラベル一覧に表示されない' do
        label = FactoryBot.create(:label1, name: '削除テスト用ラベル')
        visit labels_path
        expect(page).to have_content '削除テスト用ラベル'
        label.destroy
        visit labels_path
        expect(page).not_to have_content '削除テスト用ラベル'
      end
    end
  end
  describe 'タスクのラベル機能' do
   context 'タスクにラベルをつける' do
     it 'タスク詳細にラベルを表示する' do
       label = FactoryBot.create(:label1, name: 'テスト用ラベル')
       visit new_task_path
       fill_in 'タイトル', with: 'タスク名'
       fill_in '詳細', with: 'タスク詳細'
       fill_in '終了期限', with: '002021-03-01'
       select '未着手', from: 'ステータス'
       select '高', from: '優先度'
       check "task_label_ids_#{label.id}"
       click_on '登録する'
       expect(page).to have_content 'テスト用ラベル'
       expect(page).not_to have_content 'ラベル1'
     end
    end
  end

end
