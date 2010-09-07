class AddViewersToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :viewers, :string
  end

  def self.down
    remove_column :users, :viewers
  end
end
