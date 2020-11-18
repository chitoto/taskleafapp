class AddIndexTasksTaskTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :task_title
  end
end
