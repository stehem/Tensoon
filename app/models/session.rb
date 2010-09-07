require 'digest/sha2'

class Session < ActiveRecord::Base
attr_accessor :login , :password 
attr_protected :salt 

validates_presence_of :login , :password 

  HUMANIZED_ATTRIBUTES = {
    :login => "Identifiant",
    :password => "Mot de passe"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end







private

def self.authenticate(login,password)
if user = User.find_by_login(login)
salt = user.salt
pass = Digest::SHA256.hexdigest(password+salt)
  if User.find_by_login_and_encrypted_password(login, pass)
  return true
  end
end
end


end
