class StoriesController < ApplicationController

before_filter :login_required , :only => "poster"


require 'sanitize'



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
  redirect_to "/stories/show/#{@story.id}"
  #flash[:message] = "Story submitted"



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
  
end
