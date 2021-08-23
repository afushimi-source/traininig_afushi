class ChangeLimitToTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :title, :string, limit: 30
    change_column :tasks, :description, :text, limit: 600
  end

  def down
    change_column :tasks, :title, :string
    change_column :tasks, :description, :text
  end
end
