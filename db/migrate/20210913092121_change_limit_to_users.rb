class ChangeLimitToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :name, :string, limit: 50
    change_column :users, :email, :string, limit: 255
  end

  def down
    change_column :users, :name, :string
    change_column :users, :email, :string
  end
end
