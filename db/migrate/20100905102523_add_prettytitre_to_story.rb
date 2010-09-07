class AddPrettytitreToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :prettytitre, :string
  end

  def self.down
    remove_column :stories, :prettytitre
  end
end
