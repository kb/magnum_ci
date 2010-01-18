require 'resque'
 
module Job
  @queue = :builds
  def self.perform(params)
    sleep 1
    puts "Processed a job!"
  end
end