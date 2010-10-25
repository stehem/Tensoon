class TensoonController < ApplicationController

require 'sanitize'


def index  


  if params[:cat1] && !params[:cat2]
  @tensoon = Story.find(:all , :include => :comments , :order => "created_at DESC")
  @current = params[:cat1]
  elsif params[:cat1] && params[:cat2]
  @tensoon = Story.find(:all , :include => :comments , :conditions => ['category = ?', params[:cat2]], :order => "created_at DESC")
  @current = params[:cat1]
  @current2 = params[:cat2]
  else 
  @tensoon = Story.find(:all , :include => :comments, :order => "created_at DESC")
  @current = "Home" 
  end

if params[:cat1] == "Dernières Actus"
@tensoon
else
@tensoon.each do |s|
s.score = score(hours_since_created(s),s.votesnb)
end
@tensoon = @tensoon.sort {|a,b| b.score<=>a.score}

end

@tensoon = @tensoon.paginate :page => params[:page], :per_page => 10




  

end


def hours_since_created(story)
(Time.now.to_i/3600)-(story.created_at.to_i/3600)
end

def score(hrs , votes)
(votes+1)/((hrs+2)**1.5)
end


def hadmin
currentuser

if @currentuser && @currentuser.login == "rorschach"
#@users = User.find(:all , :order => "created_at DESC")
@stories = Story.find(:all , :order => "created_at DESC" , :limit => 20)
@users = User.find(:all)
if params[:effacer] == "oui" && params[:storyid]
Story.effacer_story(params[:storyid])
redirect_to "/hadmin"
end
else
redirect_to root_url
end


end


def faq
@current = "FAQ"
end


end




