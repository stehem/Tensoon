# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def current_user
    @current_user = session[:login]
  end
  
  def current_userid
  if @current_userid = User.find_by_login(session[:login])
  return @current_userid.id 
  end
  end


  def countvotes(id)
  @votes_total = Vote.count(:all , :conditions => [ "story_id = ?" , id ])
  return @votes_total
  end

  def alreadyvoted(story_id)
  unless current_user.nil?
  if Vote.find_by_story_id_and_user_id(story_id ,current_userid)
  return true
  end
  end
  end

  def findavatar(userid)
  @user = User.find(userid)
  @avatar = @user.avatar
  return @avatar.url(:thumb)
  end

  def setcurrent(current)
  @current = current
  end

  def noindex
  if request.request_uri == "/"
  @noindex = '<META NAME="ROBOTS" CONTENT="INDEX,FOLLOW">'
  elsif request.request_uri.match(/^\/\d+-/)
  @noindex = '<META NAME="ROBOTS" CONTENT="INDEX,FOLLOW">'
  elsif request.request_uri.match(/^\/users\/show/)
  @noindex = '<META NAME="ROBOTS" CONTENT="INDEX,FOLLOW">'
  else
  @noindex = '<META NAME="ROBOTS" CONTENT="NOINDEX,FOLLOW">'
  end
  end



end
