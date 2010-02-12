namespace :setup do
  desc "Reset and Reload the DB"
  task :reset do
    [:drop, :create, :migrate].each do |step|
      puts "#{step.to_s.capitalize} the DB"
      Rake::Task["db:#{step}"].invoke
    end
  end 
  
  desc "Setup the application (first time)"
  task :app do
    puts "Loading git submodules"
    `git submodule init && git submodule update`
    example = "#{RAILS_ROOT}/config/database.yml.example"
    if FileTest.exist? example
      puts "copying #{example} to database.yml"
      FileUtils.cp example, "#{RAILS_ROOT}/config/database.yml"
    end
    Rake::Task['setup:reset'].invoke
  end
end
