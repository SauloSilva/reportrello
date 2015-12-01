class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :token
      t.string :username
      t.string :fullname
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end