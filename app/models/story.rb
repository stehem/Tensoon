class Story < ActiveRecord::Base
belongs_to :user
has_many :comments
has_many :votes



attr_accessor :score
attr_accessor :rules

  HUMANIZED_ATTRIBUTES = {
    :snip => "Résumé" , :url => "URL de l'article" , :category => "Catégorie" , :rules => ""
  
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

validates_presence_of :titre, :snip , :url , :category
validates_length_of :titre, :maximum=>100 , :if => :titre?
validates_format_of :url, :with => /http:\/\// , :if => :url?
validates_length_of :snip, :minimum=>300 , :if => :snip?
validates_length_of :snip, :maximum=>600 , :if => :snip?
validate :lessthan1hr
validates_acceptance_of :rules

def self.prettyurl (titre)
require 'unicode'
Unicode::normalize_KD("-"+titre+"-").downcase.gsub(/[^a-z0-9\s_-]+/,'').gsub(/[\s_-]+/,'-')[0..-2]
end 

def self.last10
self.find(:all , :order => "created_at DESC" , :limit => "10")
end

  def self.findtitre(storyid)
  @s = Story(storyid)
  return @s.titre
  end

def self.nbsubmitted(poster)
self.count(:conditions => ['poster = ?', poster])
end


def lessthan1hr
dernierpost = Story.last(:conditions => ['poster = ?', self.poster])
unless !dernierpost
if (Time.now.to_i/60)-(dernierpost.created_at.to_i/60) < 60
errors.add(:delai)
end
end
end

def self.socurl (story)
  story.update_attributes(
:twurl => URI.escape("#{story.url}&amp;text=#{story.titre}") , 
:bzurl => URI.escape("#{story.url}") , 
:fburl => URI.escape("#{story.url}")
)
end

def self.effacer_story(storyid)
story = Story.find(storyid)
story.destroy
end

end
