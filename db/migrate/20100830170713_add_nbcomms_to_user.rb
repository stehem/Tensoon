class AddNbcommsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nbcomms, :integer
  end

  def self.down
    remove_column :users, :nbcomms
  end
end
