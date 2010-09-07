class AddBzurlToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :bzurl, :string
  end

  def self.down
    remove_column :stories, :bzurl
  end
end
