# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


 before_filter :meta , :sidebar #,:check_uri 

  def check_uri
    redirect_to(request.protocol + "www." + request.host_with_port + request.request_uri , :status => :moved_permanently) if !/^www/.match(request.host)
  end

  def meta
  @title = "Tensoon - l'actualité du SEO et marketing online"
  @desc = "Lisez, partagez, soumettez et votez des articles sur le SEO et tous les domaines du marketing online"
  end
 
 def sidebar
 @last10 = Story.last10
 @last10c = Comment.last10c
 end



  def findavatar(user)
  @user = User.find_by_login(user)
  @avatar = @user.avatar
  return @avatar.url(:thumb)
  end


def login_required
  
    if session[:login]
      return true
    else
    
    flash[:message]='Connectez vous pour continuer'    
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
