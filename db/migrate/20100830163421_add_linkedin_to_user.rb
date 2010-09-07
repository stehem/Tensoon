class AddLinkedinToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :linkedin, :string
  end

  def self.down
    remove_column :users, :linkedin
  end
end
