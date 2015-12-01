class CreateChecklists < ActiveRecord::Migration
  def up
    create_table :checklists do |t|
      t.text :description
      t.references :task, index: true
      t.timestamps
    end
  end

  def down
    drop_table :checklists
  end
end