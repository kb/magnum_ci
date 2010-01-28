# == Schema Information
# Schema version: 20100120025709
#
# Table name: builds
#
#  id         :integer         not null, primary key
#  project_id :integer
#  name       :string(255)
#  log        :text
#  passed     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Build < ActiveRecord::Base
  belongs_to :project
end
