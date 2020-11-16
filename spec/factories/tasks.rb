FactoryBot.define do
  factory :task, class: Task do
    task_title { 'タイトル１' }
    task_description { 'コンテント１' }
    limit { '2020-12-01' }
    status { '完了' }
  end

  factory :second_task, class: Task do
    task_title { 'タイトル２' }
    task_description { 'コンテント２' }
    limit { '2020-12-02' }
    status { '未着手' }
  end

  factory :task3, class: Task do
    task_title { 'タイトル３' }
    task_description { 'コンテント３' }
    limit { '2020-12-03' }
    status { '着手中' }
  end

  factory :task4, class: Task do
    task_title { 'あああ' }
    task_description { 'コンテント４' }
    limit { '2020-12-04' }
    status { '着手中' }
  end

  factory :task5, class: Task do
    task_title { 'あああ' }
    task_description { 'コンテント５' }
    limit { '2020-12-05' }
    status { '未着手' }
  end
end
