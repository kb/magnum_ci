# == Schema Information
# Schema version: 20101023140442
#
# Table name: builds
#
#  id         :integer         not null, primary key
#  project_id :integer
#  name       :string(50)
#  state      :string(50)
#  committer  :string(50)
#  log        :text
#  message    :text
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

  def passed?
    self.passed ? true : false
  end

  def pass_fail
    self.passed? ? "PASSED" : "FAILED"
  end

  def delete_build
    Resque.enqueue(DeleteBuild, self.id)
  end

  def pretty_date
    days_away = (Date.today - Date.new(created_at.year, created_at.month, created_at.day)).to_i
    if days_away == 0
      "Today"
    elsif days_away == 1
      "Yesterday"
    else
      created_at.strftime("%D")
    end
  end
end
