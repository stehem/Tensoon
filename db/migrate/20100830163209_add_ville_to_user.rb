class AddVilleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :ville, :string
  end

  def self.down
    remove_column :users, :ville
  end
end
