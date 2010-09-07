class CommentsController < ApplicationController

require 'rubygems'
require 'sanitize'


before_filter :login_required 

def poster
if request.post?
@comment = Comment.new(params[:comment])
@comment.votpos = @comment.votneg = 0

@comment.commentaire = Sanitize.clean(@comment.commentaire, Sanitize::Config::BASIC)

@s = @comment.story_id
if @comment.save

#User.updnbcomms(session[:login])

#flash[:message] = "Comment submitted"
redirect_to "/stories/show/#{@s}"

else 
#flash[:message] = "Comment NOT submitted"
redirect_to "/stories/show/#{@s}"
end
end
end

def vote
@comment = Comment.find(params[:id])
if !Commentsvote.has_already_voted_this_comment(currentuserid , @comment.id)

if params[:type] == "pos"
@comm_votpos_upd = @comment.votpos + 1
Comment.update(@comment, { :votpos => @comm_votpos_upd})
end
if params[:type] == "neg"
@comm_votneg_upd = @comment.votneg + 1
Comment.update(@comment, { :votneg => @comm_votneg_upd})
end

@id = params[:id]

respond_to do |format|
    format.js {
      render :update do |page|
	page.replace_html "comment_vote_#{@id}", :partial => "comments/scores"
   	page.visual_effect :pulsate, "comment_vote_#{@id}", :duration => 0.5, :queue => 'end'
      end
   }
  end

@commentsvote = Commentsvote.new
@commentsvote.comment_id = @comment.id
@commentsvote.user_id = currentuserid
@commentsvote.save

else

flash.now[:message] = "Commentaire déja voté"
respond_to do |format|
    format.js {
      render :update do |page|
	page.replace_html "fmsg#{@comment.id}" , flash[:message]
	page.visual_effect :pulsate, "fmsg#{@comment.id}" , :duration => 0.5, :queue => 'end'
   
      end
   }
  end

end
end



end
