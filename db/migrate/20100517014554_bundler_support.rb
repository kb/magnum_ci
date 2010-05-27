class BundlerSupport < ActiveRecord::Migration
  def self.up
    add_column :projects, :bundler, :boolean
  end

  def self.down
    add_column :projects, :bundler
  end
end
