class AddBlogToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :blog, :string
  end

  def self.down
    remove_column :users, :blog
  end
end
