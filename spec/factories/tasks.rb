FactoryBot.define do
  factory :task do
    task_title { 'Factoryで作ったデフォルトのタイトル１' }
    task_description { 'Factoryで作ったデフォルトのコンテント１' }
  end

  factory :second_task, class: Task do
    task_title { 'Factoryで作ったデフォルトのタイトル２' }
    task_description { 'Factoryで作ったデフォルトのコンテント２' }
  end
end
