class CreateCommentsvotes < ActiveRecord::Migration
  def self.up
    create_table :commentsvotes do |t|
      t.integer :comment_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :commentsvotes
  end
end
