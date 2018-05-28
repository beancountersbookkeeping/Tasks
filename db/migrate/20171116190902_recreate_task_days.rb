class RecreateTaskDays < ActiveRecord::Migration
  def change
    add_column :tasks, :recreate_task_days, :integer
  end
end
