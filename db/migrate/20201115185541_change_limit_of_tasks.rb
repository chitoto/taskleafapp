class ChangeLimitOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :limit, :date, default: "2021-03-31"
  end
end
