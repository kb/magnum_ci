# == Schema Information
# Schema version: 20100120025709
#
# Table name: projects
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  repo_uri          :string(255)
#  branch            :string(255)
#  script            :string(255)
#  keep_build_number :integer(2)
#  created_at        :datetime
#  updated_at        :datetime
#

class Project < ActiveRecord::Base
  validates_presence_of :name, :repo_uri, :branch, :script, :keep_build_number, :message => "cannot be blank"
  validates_format_of :name, :branch, :with => /^[A-Za-z\d_]+$/, :message => "cannot contain spaces"
  validates_uniqueness_of :name
  validates_numericality_of :keep_build_number
  
  has_many :builds
  
  after_create :create_build_dir
  
  def run_build
    # This is a bit unorthadox, however resque stores items as json objects.
    # Meaning we need to pass an id, instead of an object
    build = Build.create!
    self.builds << build
    Resque.enqueue(MagnumCI::RobinsNest, build.id)
    (self.builds.size - keep_build_number).times.each do |i|
        self.builds[i].delete_build
    end
  end

  private
  def create_build_dir
    Dir.mkdir "#{RAILS_ROOT}/builds/#{self.name}" unless File.exist? "#{RAILS_ROOT}/builds/#{self.name}"
  end
end
