class RemoveStoryIdFromVotes < ActiveRecord::Migration
  def self.up
    remove_column :votes, :story_id
  end

  def self.down
    add_column :votes, :story_id, :integer
  end
end
