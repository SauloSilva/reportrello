class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.string :name
      t.string :description
      t.string :status
      t.text :log
      t.timestamp :reported_at
      t.references :user, index: true
      t.timestamps
    end
  end

  def down
    drop_table :reports
  end
end