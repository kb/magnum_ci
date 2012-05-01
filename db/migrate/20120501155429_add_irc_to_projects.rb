class AddIrcToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :irc, :boolean
    add_column :projects, :channel, :string
    add_column :projects, :ircserver, :string
    add_column :projects, :ircnick, :string
  end

  def self.down
    remove_column :projects, :irc
    remove_column :projects, :channel
    remove_column :projects, :server
    remove_column :projects, :ircnick
  end
end
