# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password



 



  def findavatar(user)
  @user = User.find_by_login(user)
  @avatar = @user.avatar
  return @avatar.url(:thumb)
  end


def login_required
  
    if session[:login]
      return true
    else
    
    flash[:message]='Please login to continue'    
    redirect_to "/sessions/login"
    session[:return_to] = request.request_uri
    end
  end


 def currentuser
    @currentuser = User.find_by_login(session[:login])
  end

  def currentuserid
  @current_userid = User.find_by_login(session[:login])
  return @current_userid.id
  end




end
