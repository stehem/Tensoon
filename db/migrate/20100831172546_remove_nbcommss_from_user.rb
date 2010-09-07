class RemoveNbcommssFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :nbcomms
  end

  def self.down
    add_column :users, :nbcomms, :string
  end
end
