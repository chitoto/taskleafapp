class ChangeColumnNullTaskName < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :task_title, false
  end
end
