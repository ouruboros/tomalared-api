class Post < ActiveRecord::Base

#  include Tenacity
#  include Mongoid::Document

  # field :title
  # field :content
  # has_many :interactions, :dependent => :destroy
  has_many :users # , :through => :interactions
  has_many :comments #, -> { order 'position desc' }, :dependent => :destroy
  # t_has_many :notifications, :dependent => :destroy
  has_and_belongs_to_many :tags
  belongs_to :user
#  has_many :likes, :foreign_key => 'type_id', -> { where like_type: 1}, :dependent => :destroy
  # has_many :shares, :dependent => :destroy
  
#  attr_accessible :id, :title, :post_type, :content, :user_id, :tags, :notifications, :interactions

  def self.search(query)
    if query
      tokens = query.split.collect {|c| "%#{c.downcase}%"} 
      r = find_by_sql(["SELECT * from posts WHERE post_type != 'image' and #{ (["LOWER(content) like ?"] * tokens.size).join(" OR ") }", *tokens])
      return r.uniq # No need for duplicate entries
    end
  end
end

