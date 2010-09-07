class AddFacebookToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook, :string
  end

  def self.down
    remove_column :users, :facebook
  end
end
