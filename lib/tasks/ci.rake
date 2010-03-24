require 'cucumber'
require 'cucumber/rake/task'
require 'webrat'

namespace :ci do
  desc "Setup the application for CI"
  task :setup do
    `git submodule init && git submodule update`
    FileUtils.cp "#{RAILS_ROOT}/config/database.yml.example", "#{RAILS_ROOT}/config/database.yml"
    Rake::Task['setup:reset'].invoke
  end

  desc "CI build task"
  task :all do
    RAILS_ENV = 'test'
    Rake::Task['log:clear'].invoke
    Rake::Task['ci:setup'].invoke
    Rake::Task['spec'].invoke
    Rake::Task['ci:features'].invoke
  end

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "-p default --format progress -q"
  end

  desc "Run an individual cucumber feature/scenario"
  task :feature, :feature do |task, args|
    Cucumber::Rake::Task.new(:feature_task) do |t|
      t.cucumber_opts = "-p default features/#{args[:feature]}"
    end
    Rake::Task['feature_task'].invoke
  end
end
