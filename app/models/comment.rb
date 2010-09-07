class Comment < ActiveRecord::Base
belongs_to :story
belongs_to :user
validates_presence_of :commentaire

def self.last10c
self.find(:all , :order => "created_at DESC" , :limit => "10" , :include => :story)
end

attr_accessor :titre

end
