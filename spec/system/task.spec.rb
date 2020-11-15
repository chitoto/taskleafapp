require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, task_title: 'task') }
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'タイトル', with: 'タスク名'
      fill_in '詳細', with: 'タスク詳細'
      click_on '登録する'
      expect(page).to have_content 'タスク名'
      expect(page).to have_content 'タスク詳細'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '終了期限でソートした場合' do
      it '期限の近いタスクが一番上に表示される' do
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル２'
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
