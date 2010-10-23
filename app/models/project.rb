# == Schema Information
# Schema version: 20101023140442
#
# Table name: projects
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  repo_uri          :string(255)
#  branch            :string(255)
#  script            :string(255)
#  account           :string(255)
#  room              :string(255)
#  token             :string(255)
#  campfire          :boolean
#  ssl               :boolean
#  bundler           :boolean
#  keep_build_number :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Project < ActiveRecord::Base
  validates_presence_of :name, :repo_uri, :branch, :script, :keep_build_number, :message => "cannot be blank"
  validates_format_of :name, :branch, :with => /^[A-Za-z\d_]+$/, :message => "cannot contain spaces"
  validates_uniqueness_of :name
  validates_numericality_of :keep_build_number

  has_many :builds, :dependent => :destroy

  after_create :create_build_dir
  before_destroy :rm_build_dir

  def run_build
    # This is a bit unorthadox, however resque stores items as json objects.
    # Meaning we need to pass an id, instead of an object
    build = Build.create!
    self.builds << build
    Resque.enqueue(CloneBuild, build.id)
    (self.builds.size - keep_build_number).times.each do |i|
      self.builds[i].delete_build
    end
  end

  def campfire_settings
    {'account' => self.account, 'token' => self.token, 'use_ssl' => self.ssl}
  end

  def bundler?
    self.bundler ? true : false
  end

  private
  def create_build_dir
    Dir.mkdir "#{Rails.root}/builds/#{self.name}" unless File.exist? "#{Rails.root}/builds/#{self.name}"
  end

  def rm_build_dir
    FileUtils.rm_rf("#{Rails.root}/builds/#{self.name}")
  end
end
