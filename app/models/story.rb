class Story < ActiveRecord::Base

require 'twitter'
require 'oauth'


belongs_to :user
has_many :comments
has_many :votes



attr_accessor :score
attr_accessor :rules
attr_accessor :upd

  HUMANIZED_ATTRIBUTES = {
    :snip => "Résumé" , :url => "URL de l'article" , :category => "Catégorie" , :rules => ""
  
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

validates_presence_of :titre, :snip , :url , :category
validates_length_of :titre, :maximum=>100 , :if => :titre?
validates_format_of :url, :with => /http:\/\// , :if => :url?
validates_length_of :snip, :minimum=>150 , :if => :snip?
validates_length_of :snip, :maximum=>600 , :if => :snip?
validate :lessthan1hr, :unless => :skip_delay
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
unless !dernierpost || dernierpost.poster == "rorschach"
if (Time.now.to_i/60)-(dernierpost.created_at.to_i/60) < 60
errors.add(:delai)
end
end
end

def skip_delay
if self.upd == 1
true
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


def self.twitt(id,prettytitre,titre)
shorturl = Net::HTTP.get 'is.gd', '/api.php?longurl=' + CGI.escape("http://www.tensoon.fr/#{id}#{prettytitre}?utm_source=twitter")
accroche = titre[0..106]
oauth = Twitter::OAuth.new('yHAmmp3qDV73QokCksH6w', 'JkJWrLTpqcR2ykkNDNJhAT1E93xhf5D6c2X0lh9Nrs')
oauth.authorize_from_access('190426884-IbJxSJfjiF0id1Pm09xVc8NN7sFDTsoswosrZZ8s', '71FJ7OdQBC6KE5Jylb3B0hAOQFJ7eI92GztGksvLq4')
client = Twitter::Base.new(oauth)
client.update(accroche + " " + shorturl + " " + "#référencement")
end



end
