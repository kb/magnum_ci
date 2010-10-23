class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.belongs_to :project
      t.string :name, :state, :committer, :limit => 50
      t.text :log, :message
      t.boolean :passed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end
