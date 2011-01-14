class User < ActiveRecord::Base

  self.primary_key=:fb_id
  
  has_and_belongs_to_many :links,  :foreign_key => "user_fb_id", :association_foreign_key => "link_id"
  validates_uniqueness_of :fb_id
  

  
  def self.create_with_omniauth(auth)  
    puts auth.to_yaml
    create! do |user|  
      user.fb_id        = auth["uid"]  
      user.name         = auth["user_info"]["name"]  
      user.access_token = auth["credentials"]["token"]
    end  
  end  

  def fetch_data
    begin
      @feeds ||= FGraph.me_home(:access_token => access_token)
    rescue
      puts 'error while fetching data'
    end
  end

  def update_links
    link_feeds = fetch_data.select {|feed| feed['type'] == 'link' }
    link_feeds.each do |feed|
      user  =  User.parse_feed(feed)
      link  =  Link.parse_feed(feed)
      unless user.link_ids.include? link.id
        user.links << link 
        link.adjust_counters(feed)
      end
    end
  end 

  def self.parse_feed(feed)
    user = find_by_fb_id(feed['from']['id']) || new(:name => feed['from']['name'])
    user.fb_id=feed['from']['id']  #Mass assignment not possible
    user.save
    user
  end

end
