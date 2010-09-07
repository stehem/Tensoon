class AddTwurlToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :twurl, :string
  end

  def self.down
    remove_column :stories, :twurl
  end
end
