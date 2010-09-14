class MoncompteController < ApplicationController

before_filter :login_required 

def index
@user = User.find_by_login(session[:login])
@nb = Story.nbsubmitted(session[:login])
end

def edit
@user = User.find_by_login(session[:login])
@nb = Story.nbsubmitted(session[:login])


   if request.post?
       @user.upd = 1
        if @user.update_attributes(params[:user])
        redirect_to :action => 'index'
        if params[:user]
         flash[:avert] = "Informations modifiées"
          end
           end
      end


end

end
