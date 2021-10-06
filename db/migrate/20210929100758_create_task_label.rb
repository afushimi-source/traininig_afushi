class CreateTaskLabel < ActiveRecord::Migration[5.2]
  def change
    create_table :task_labels do |t|
      t.integer :task_id, null: false
      t.integer :label_id, null: false
      t.timestamps
    end
    add_index :task_labels, :task_id
    add_index :task_labels, :label_id
    add_index :task_labels, [:task_id, :label_id], unique: true
  end
end
