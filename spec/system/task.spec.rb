require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'Task title', with: 'タスク名'
      fill_in 'Task description', with: 'タスク詳細'
      click_on 'Create Task'
      expect(page).to have_content 'タスク名'
      expect(page).to have_content 'タスク詳細'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
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
