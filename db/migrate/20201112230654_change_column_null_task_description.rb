class ChangeColumnNullTaskDescription < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :task_description, false
  end
end
