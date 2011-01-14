class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :fb_id
      t.string :name
      t.string :access_token

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
