class ChangeColumnNullLimit < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :limit, false
  end
end
