class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.text :url
      t.string :hash
      t.integer :comments_count, :default => 0
      t.integer :likes_count, :default => 0
      t.integer :shares_count, :default => 0
      t.timestamp :last_updated

      t.timestamps
    end
    add_index :links, :hash,              :unique => true
  end

  def self.down
    drop_table :links
  end
end
