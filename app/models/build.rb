# == Schema Information
# Schema version: 20100120025709
#
# Table name: builds
#
#  id         :integer         not null, primary key
#  project_id :integer
#  name       :string(50)
#  state      :string(50)
#  log        :text
#  passed     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Build < ActiveRecord::Base
  include AASM
  
  belongs_to :project

  aasm_column :state
  aasm_initial_state :clone_queued
  aasm_state :clone_queued
  aasm_state :cloning
  aasm_state :build_queued
  aasm_state :building
  aasm_state :built

  aasm_event :clone do
    transitions :to => :cloning, :from => [:clone_queued]
  end

  aasm_event :queue_build do
    transitions :to => :build_queued, :from => [:cloning]
  end

  aasm_event :run_build do
    transitions :to => :building, :from => [:build_queued]
  end

  aasm_event :complete_build do
    transitions :to => :built, :from => [:building]
  end
end
