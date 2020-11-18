class AddIndexTasksTaskTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :task_title
    add_index :tasks, :task_description
    add_index :tasks, :status
  end
end
