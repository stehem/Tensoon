class AddAvatarurlToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :avatarurl, :string
  end

  def self.down
    remove_column :stories, :avatarurl
  end
end
