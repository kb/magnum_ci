require File.dirname(__FILE__) + '/../spec_helper'

describe Build do  
  it "should create a new instance given valid attributes" do
    lambda do
      Build.create!(:log => "test test test test test", :passed => true)
    end.should change(Build, :count).by(1)
  end
end
