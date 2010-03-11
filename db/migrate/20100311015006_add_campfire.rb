class AddCampfire < ActiveRecord::Migration
  def self.up
    add_column :projects, :campfire, :boolean
    add_column :projects, :account, :string
    add_column :projects, :token, :string
    add_column :projects, :ssl, :boolean
    add_column :projects, :room, :string
  end

  def self.down
    remove_column :projects, :campfire
    remove_column :projects, :account
    remove_column :projects, :token
    remove_column :projects, :ssl
    remove_column :projects, :room
  end
end
