class AddCommitMessage < ActiveRecord::Migration
  def self.up
    add_column :builds, :message, :text
  end

  def self.down
    remove_column :builds, :message
  end
end
