require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
end

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

