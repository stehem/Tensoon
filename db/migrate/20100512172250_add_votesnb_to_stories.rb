class AddVotesnbToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :votesnb, :integer
  end

  def self.down
    remove_column :stories, :votesnb
  end
end
