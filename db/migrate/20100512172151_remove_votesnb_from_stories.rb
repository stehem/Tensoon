class RemoveVotesnbFromStories < ActiveRecord::Migration
  def self.up
    remove_column :stories, :votesnb
  end

  def self.down
    add_column :stories, :votesnb, :string
  end
end
