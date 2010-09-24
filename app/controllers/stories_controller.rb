class StoriesController < ApplicationController

before_filter :login_required , :only => "poster"


require 'sanitize'
require 'twitter'
require 'oauth'


  def poster

  if request.post?
  @story = Story.new(params[:story])
  @story.source = @story.url.split('/')[2] 
  @story.poster = session[:login]
  @story.votesnb = "1"
  @story.avatarurl = findavatar(@story.poster)
  @story.titre = Sanitize.clean(@story.titre, Sanitize::Config::RESTRICTED)
  @story.url = Sanitize.clean(@story.url, Sanitize::Config::RESTRICTED)
  @story.snip = Sanitize.clean(@story.snip, Sanitize::Config::RESTRICTED)
  @story.prettytitre = Story.prettyurl(@story.titre)
  @story.twurl = URI.escape("#{@story.url}&amp;text=#{@story.titre}")
  @story.fburl = URI.escape("#{@story.url}")
  @story.bzurl = URI.escape("#{@story.url}")
  if @story.save
  #Story.socurl (@story)
  redirect_to "/#{@story.id}#{@story.prettytitre}"
  #flash[:message] = "Story submitted"


if @story.poster == "rorschach"
Story.twitt(@story.id,@story.prettytitre,@story.titre)
end




  end
  end
  @current = "Home"
  end

  def show
  @story = Story.find_by_id(params[:id].to_i)
  @current = "Home"
  @title = @story.titre
  @desc = @story.snip
  end

  def rules
  render :partial => 'rules'
  end

def edit
@story = Story.find(params[:id])


   if request.post?
        if @story.update_attributes(params[:story])
        redirect_to "/#{@story.id}#{@story.prettytitre}"
           end
      end


end

def retwitt
Story.twitt(params[:id],params[:prettytitre],params[:titre])
flash[:retwitt] = "retwitté"
redirect_to "/hadmin"
end
  
end
