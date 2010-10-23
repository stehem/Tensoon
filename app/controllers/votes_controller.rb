class VotesController < ApplicationController
#before_filter :login_required , :only => "vote"

 def vote

  @s = params[:story_id]

  #if currentuser

  voterip = request.remote_ip
  story_id = params[:story_id]
  #@story = Story.find(story_id)

  if !Vote.has_already_voted(voterip,story_id)




  @sto = Story.find(params[:story_id])

  #if !Vote.has_already_voted(params[:story_id] , currentuserid ) && @sto.poster != currentuser.login


  @vote = Vote.new(:story_id => story_id, :voterip => voterip)
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



respond_to do |format|
    format.js {
      render :update do |page|
	page.replace_html "votelink#{@s}" , :partial => "votes/dejavote"
	page.visual_effect :pulsate, "votelink#{@s}" , :duration => 0.5, :queue => 'end'
      end
   }
  end



 # else

 # respond_to do |format|
   # format.js {
   #   render :update do |page|
    #    page.redirect_to "/sessions/login"
    #  end
  # }
  #end


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
