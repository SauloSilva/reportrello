class CreateEnvironments < ActiveRecord::Migration
  def up
    create_table :environments do |t|
      t.string :name
      t.string :board_name
      t.string :list_name
      t.string :checklist_name
      t.references :report, index: true
      t.timestamps
    end
  end

  def down
    drop_table :environments
  end
end