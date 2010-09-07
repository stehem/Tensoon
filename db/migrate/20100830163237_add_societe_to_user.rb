class AddSocieteToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :societe, :string
  end

  def self.down
    remove_column :users, :societe
  end
end
