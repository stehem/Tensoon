class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.string :user_login
      t.string :commentaire
      t.integer :votpos
      t.integer :votneg

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
