require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_title: '', task_description: '失敗テスト', status: '未着手')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_title: '失敗テスト', task_description: '', status: '未着手')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_title: 'テスト', task_description: 'テスト', status: '未着手')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, task_title: 'task', task_description: 'テスト', status: '完了')}
    let!(:second_task) { FactoryBot.create(:second_task, task_title: "sample", task_description: 'テスト', status: '完了')}
    let!(:task3) { FactoryBot.create(:second_task, task_title: "task", task_description: 'テスト', status: '未着手')}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(second_task)
        expect(Task.search_title('task').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('完了')).not_to include(task3)
        expect(Task.search_status('完了').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task').search_status('完了')).to include(task)
        expect(Task.search_title('task').search_status('完了')).not_to include(second_task)
        expect(Task.search_title('task').search_status('完了').count).to eq 1
      end
    end
  end

end
