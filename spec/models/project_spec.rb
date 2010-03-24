# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  repo_uri   :string(255)
#  branch     :string(255)
#  script     :string(255)
#  public     :boolean
#  created_at :datetime
#  updated_at :datetime
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should create a new instance given valid attributes" do
    lambda do
      Project.create!(:name => 'test', :repo_uri => 'git://example.com:test.git', :branch => 'master', :script => 'rake test', :keep_build_number => 15)
    end.should change(Project, :count).by(1)
    FileUtils.rm_rf("#{RAILS_ROOT}/builds/test")
  end
  
  it "should NOT create a new instance given invalid attributes" do
    lambda do
      Project.create()
    end.should_not change(Project, :count)
  end
  
  it "should create a new project with builds" do 
    project = nil
    lambda do
      project = Project.make
      project.builds << Build.make
    end.should change(Build, :count).by(1)
    project.should have(1).build
    FileUtils.rm_rf("#{RAILS_ROOT}/builds/#{project.name}")
  end
end
