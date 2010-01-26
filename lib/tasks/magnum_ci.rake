require 'cucumber'
require 'cucumber/rake/task'

namespace :magnum_ci do
  desc "Magnum C.I. build task"
  task :all do
    RAILS_ENV = 'test'
    Rake::Task['log:clear'].invoke
    Rake::Task['setup:app'].invoke
    Rake::Task['spec'].invoke
    Rake::Task['magnum_ci:features'].invoke
    # Rake::Task['magnum_ci:selenium_features'].invoke
  end

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "-p default --format progress -q"
  end

  Cucumber::Rake::Task.new(:selenium_features) do |t|
    t.cucumber_opts = "-p selenium --format progress -q"
  end
end