class LinksUsers < ActiveRecord::Migration
  
  def self.up
    create_table :links_users, :id => false do |t|
      t.integer :link_id
      t.string :user_fb_id
    end
  end

  def self.down
    drop_table :links_users
  end

end
