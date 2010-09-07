class AddStoryIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :story_id, :integer
  end

  def self.down
    remove_column :comments, :story_id
  end
end
