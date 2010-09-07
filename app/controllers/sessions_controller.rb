class SessionsController < ApplicationController



def login

unless session[:return_to]
session[:return_to] = request.referer
end

if request.post?
@session = Session.new(params[:session])
  if @session.valid?
    if Session.authenticate(params[:session][:login],params[:session][:password])
    session[:login] = @session.login

      if session[:return_to]
      if session[:return_to].match(/users\/signup/)
      redirect_to root_url
      else
      redirect_to session[:return_to]
      session[:return_to] = nil
      end
      else
      redirect_to root_url
      end


    else
    flash[:message]="Utilisateur et/ou mot de passe erronés"
    end
  end
end
 @current = "Home"
end

def logout
session[:login] = nil
flash[:message]="Vous êtes maintenant déconnecté"
redirect_to(root_url)
end

end
