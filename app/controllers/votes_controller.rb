class VotesController < ApplicationController
#before_filter :login_required , :only => "vote"

  def vote

  @s = params[:story_id]

  if currentuser

  @sto = Story.find(@s)

  if !Vote.has_already_voted(params[:story_id] , currentuserid ) && @sto.poster != currentuser.login


  @vote = currentuser.votes.build(:story_id => params[:story_id])
  @vote.save
  Vote.increment(@sto)
  @nb = @sto.votesnb + 1
  
#@sto.votesnb =+ 1
#@sto.save

@sto.update_attribute(:votesnb , @nb)



  respond_to do |format|
    format.js {
      render :update do |page|
	page.replace_html "vote#{@s}", :partial => "votes/votes"
   	page.visual_effect :pulsate, "vote#{@s}", :duration => 1, :queue => 'end'
      end
   }
  end
  #end


  else


flash[:message] = "deja vote"
respond_to do |format|
    format.js {
      render :update do |page|
	page.replace_html "votelink#{@s}" , :partial => "votes/dejavote"
	page.visual_effect :pulsate, "votelink#{@s}" , :duration => 0.5, :queue => 'end'
      end
   }
  end


  end


  else

  respond_to do |format|
    format.js {
      render :update do |page|
        page.redirect_to "/sessions/login"
      end
   }
  end

end

  end



  def votesignup
  respond_to do |format|
    format.js {
      render :update do |page|
	page.replace_html "msg", :partial => "votes/votesignup"
   	page.visual_effect :appear, :msg, :duration => 1, :queue => 'end'
      end
   }
  end
  end

end
