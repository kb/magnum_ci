# == Schema Information
# Schema version: 20100118221722
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  repo_uri   :string(255)
#  branch     :string(255)
#  script     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  validates_presence_of :name, :repo_uri
  validates_uniqueness_of :name
  
  has_many :builds
end
