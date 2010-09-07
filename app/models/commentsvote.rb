class Commentsvote < ActiveRecord::Base

def self.has_already_voted_this_comment(userid , commentid)
if Commentsvote.find_by_user_id_and_comment_id(userid , commentid)
return true
end
end

end
