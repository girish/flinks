class Link < ActiveRecord::Base


  has_and_belongs_to_many :users, :foreign_key => "link_id", :association_foreign_key => "user_fb_id" 
  validates_uniqueness_of :hash
  before_save :normalize_url


  def normalize_url
    self.hash=Digest::MD5.hexdigest(url)
  end

  #shared count is no of users shared
  #so dynamically retrieve it
  def shares_count
    users.size
  end

  def self.parse_feed(feed)
   
    link                = find_by_hash(Digest::MD5.hexdigest(feed['link'])) || new(:likes_count =>0, :comments_count=>0)
    link.url            = feed["link"]
    link.last_updated   = Time.parse(feed["updated_time"])
    link.save_if_latest 
    link
  end

  def adjust_counters(feed)
    self.likes_count    += (feed['likes'] && feed['likes']['count']).to_i
    self.comments_count += (feed['comments'] && feed['comments']['count']).to_i
    print [likes_count, comments_count]
    save
  end


  def updated_data?
    new_record? || (changes[:last_updated][0] < changes[:last_updated][1]) if changes.has_key?(:last_updated) 
  end

  def save_if_latest
    save if updated_data? 
  end

end
