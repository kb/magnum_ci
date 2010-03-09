require 'cucumber'
require 'cucumber/rake/task'

namespace :magnum_ci do
  desc "Magnum C.I. build task"
  task :all do
    RAILS_ENV = 'test'
    Rake::Task['log:clear'].invoke
    Rake::Task['setup:app'].invoke
    Rake::Task['spec'].invoke
    `bundle exec cucumber -p default --format progress -q features`
    `bundle exec cucumber -p selenium --format progress -q features`
  end
end