class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.string :name
      t.string :description
      t.references :import, index: true
      t.timestamps
    end
  end

  def down
    drop_table :reports
  end
end