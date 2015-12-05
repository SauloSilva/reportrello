class CreateImports < ActiveRecord::Migration
  def up
    create_table :imports do |t|
      t.string :board_name
      t.string :list_name
      t.string :checklist_name
      t.string :environment
      t.timestamp :imported_at
      t.references :user, index: true
      t.timestamps
    end
  end

  def down
    drop_table :imports
  end
end