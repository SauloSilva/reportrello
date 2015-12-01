class CreateTasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name
      t.references :report, index: true
      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end