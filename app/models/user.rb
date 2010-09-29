require 'digest/sha2'

class User < ActiveRecord::Base

serialize :viewers

attr_reader :password
attr_accessor :upd

has_many :stories 
has_many :votes 
has_many :comments

has_attached_file :avatar , :styles => { :thumb => "64x64>" } , :storage => :s3, 
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
      :path => "/:style/:filename"
validates_attachment_size :avatar, :less_than => 0.1.megabytes , :if => :avatar?
validates_format_of :email, :with => /.+@.+\..+/ , :if => :email?
validates_format_of :societe , :with => /http:\/\// , :if => :societe?
validates_format_of :blog , :with => /^http:\/\// , :if => :blog?
validates_format_of :twitter , :with => /^http:\/\// , :if => :twitter?
validates_format_of :linkedin , :with => /^http:\/\// , :if => :linkedin?
validates_format_of :facebook , :with => /^http:\/\// , :if => :facebook?
validates_confirmation_of :password 
validates_presence_of :login , :password ,:if => :should_validate_logpass
validates_uniqueness_of :login
#validates_attachment_presence :avatar , :message => "ne peut pas être vide"
validates_length_of :login , :maximum => 15



before_save :encrypt_password

  HUMANIZED_ATTRIBUTES = {
    :login => "Identifiant",
    :password => "Mot de passe",
    :avatar_file_name => "Avatar"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

def password=(password)
@password = password
end

def encrypt_password
return unless @password
self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
self.encrypted_password = Digest::SHA256.hexdigest(@password+self.salt)
end

def self.updnbcomms(login)
us = self.find_by_login(login)
newcount = us.nbcomms + 1
us.update_attribute :nbcomms , newcount
end

def should_validate_logpass
if self.upd != 1
true
end
end

def should_validate_email
true unless !self.email
end


#def self.addtoviewers(viewer , profile)
#if profile.viewers
#profile.viewers = profile.viewers + "," + viewer.login
#else
#profile.viewers = viewer.login
#end
#profile.update_attribute :viewers , profile.viewers
#end


end
