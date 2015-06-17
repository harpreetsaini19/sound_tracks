class Search < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of :artist_name, :user_id, :user
end
