class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.string :name
      t.string :description
      t.string :board_name
      t.string :list_name
      t.string :checklist_name
      t.string :environment
      t.timestamp :reported_at
      t.references :user, index: true
      t.timestamps
    end
  end

  def down
    drop_table :reports
  end
end