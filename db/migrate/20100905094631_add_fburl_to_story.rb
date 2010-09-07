class AddFburlToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :fburl, :string
  end

  def self.down
    remove_column :stories, :fburl
  end
end
