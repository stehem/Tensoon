class Vote < ActiveRecord::Base
belongs_to :user
belongs_to :story

def self.finduser(login)
User.find_by_login(login)
end

def self.increment(story)
inc = story.votesnb + 1

end

def self.updatevotenb(story)
@story = Story.find_by_id(story)
@voteupdate = @story.votesnb
return @voteupdate
end

def self.findstory(story)
Story.find_by_id(story)
end

def self.has_already_voted(storyid , userid)
Vote.find_by_user_id_and_story_id(userid , storyid)
end




end
