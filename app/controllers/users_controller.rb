class UsersController < ApplicationController

require 'sanitize'

def signup

@user = User.new(params[:user])
  if request.post?
    #@user.nbcomms = 0

  @user.login = Sanitize.clean(@user.login, Sanitize::Config::RESTRICTED) 
  @user.email = Sanitize.clean(@user.email, Sanitize::Config::RESTRICTED) 
  @user.societe = Sanitize.clean(@user.societe, :elements => ['http'])

  @user.ville = Sanitize.clean(@user.ville, Sanitize::Config::RESTRICTED) 
  @user.blog = Sanitize.clean(@user.blog, :elements => ['http']) 
  @user.twitter = Sanitize.clean(@user.twitter, :elements => ['http']) 
  @user.linkedin = Sanitize.clean(@user.linkedin, :elements => ['http']) 
  @user.facebook = Sanitize.clean(@user.facebook, :elements => ['http']) 


if verify_recaptcha   

    if @user.save 
    flash[:notice] = "Utilisateur créé, vous pouvez maintenant vous connecter"
    redirect_to "/sessions/login"
    end
  

   else 
   flash.now[:error] = "Les mots saisis sont différents de ceux de l'image"
   end

end


 @current = "Home"
end

def show
@user = User.find_by_login(params[:user])
currentuser #@currentuser

unless !@currentuser

@nb = Story.nbsubmitted(params[:user])
#User.addtoviewers(currentuser , @user) unless !currentuser

if !@user.viewers
@user.viewers = @currentuser.login
else
@user.viewers << " , " + "#{@currentuser.login}"
end

@b = @user.viewers.split(/ , /)

while @b.length > 5 do
@b.delete_at(0)
end
@user.viewers = @b.join(" , ")
@user.update_attribute :viewers , @user.viewers

end

#@a = @user.viewers.split(" ") unless !@user.viewers
end

end
