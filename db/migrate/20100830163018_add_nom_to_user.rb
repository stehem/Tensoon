class AddNomToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nom, :string
  end

  def self.down
    remove_column :users, :nom
  end
end
