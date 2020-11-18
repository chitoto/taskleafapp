require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task)}
  before do
    FactoryBot.create(:second_task)
    FactoryBot.create(:task3)
    FactoryBot.create(:task4)
    FactoryBot.create(:task5)
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'タイトル', with: 'タスク名'
      fill_in '詳細', with: 'タスク詳細'
      fill_in '終了期限', with: '002021-03-01'
      select '未着手', from: 'ステータス'
      select '高', from: '優先度'
      click_on '登録する'
      expect(page).to have_content 'タスク名'
      expect(page).to have_content 'タスク詳細'
      expect(page).to have_content '2021年03月01日'
      expect(page).to have_content '未着手'
      expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'タイトル１'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'コンテント５'
        expect(task_list[1]).to have_content 'コンテント４'
      end
    end
    context '終了期限でソートした場合' do
      it '期限の近いタスクが一番上に表示される' do
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル１'
        expect(task_list[1]).to have_content 'タイトル２'
      end
    end
    context 'タイトルで検索した場合' do
      it '検索ワード以外は表示されない' do
      fill_in 'title_key', with: '３'
      click_on 'Search'
      expect(page).to have_content 'タイトル３'
      expect(page).not_to have_content 'タイトル１'
      end
    end
    context 'ステータスで検索した場合' do
      it '検索ワード以外は表示されない' do
      select '未着手', from: 'search_status'
      click_on 'Search'
      expect(page).to have_content 'タイトル２'
      expect(page).not_to have_content 'タイトル３'
      expect(page).not_to have_content 'タイトル１'
      end
    end
    context 'タイトルとステータスで検索した場合' do
      it '検索ワード以外は表示されない' do
      fill_in 'title_key', with: 'あああ'
      select '未着手', from: 'search_status'
      click_on 'Search'
      expect(page).to have_content 'コンテント５'
      end
    end
    context '優先度でソートした場合' do
      it '優先度の高いタスクが一番上に表示される' do
        click_on '優先順位でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル１'
        expect(task_list[1]).to have_content 'あああ'
        expect(task_list[2]).to have_content 'タイトル２'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, task_title: '詳細用タスク')
         visit task_path(task)
         expect(page).to have_content '詳細用タスク'
       end
     end
  end
end
