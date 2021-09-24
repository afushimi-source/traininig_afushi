class CreateLabelMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :label_maps do |t|
      t.integer :task_id, null: false
      t.integer :label_id, null: false
      t.timestamps
    end
    add_index :label_maps, :task_id
    add_index :label_maps, :label_id
    add_index :label_maps, [:task_id, :label_id], unique: true
  end
end
