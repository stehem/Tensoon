class AddStoryIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :story_id, :integer
  end

  def self.down
    remove_column :votes, :story_id
  end
end
