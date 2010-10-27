# This task comes from here http://gist.github.com/486161
# Rake task to launch multiple Resque workers in development/production with simple management included

require 'resque/tasks' # Require Resque tasks

namespace :workers do

  # = $ rake workers:start
  #
  # Launch multiple Resque workers with the Rails environment loaded,
  # so they have access to your models, etc.
  #
  # Each worker is being run in their own separate process (_not_ thread).
  #
  # First started group of workers is considered "main group", whose PIDs are
  # saved into pid files in tmp/pids/resque/*.pid. When any worker from this
  # group exits, it kills the master process as well.
  # This is because we want to monitor this group as a whole.
  #
  # Any subsequently started group is considered an "ad hoc" group. Their PIDs
  # are not saved. When any worker from this group exits, the master process
  # and other workers continue running. This is because we don't care about
  # workers in this group.
  #
  # On clean shutdown (SIGINT / Ctrl-C, SIGQUIT, SIGTERM), the task will clean
  # after itself: kill its workers and delete PID files, when appropriate. It
  # will deal fine with already dead workers.
  #
  # Default options like COUNT can and should be over-ridden when invoking, of course:
  #
  #    $ rake workers:start COUNT=10 QUEUE=my_queue
  #
  # To daemonize, simply run with nohup:
  #
  #    $ nohup rake workers:start > log/workers.log 2>&1 &
  #
  # You can set up your monitoring tool to watch for process with PID
  # from `cat tmp/pids/resque/master.pid`.
  #
  # For proper monitoring of _individual_ workers, use provided examples for God or Monit:
  # http://github.com/defunkt/resque/blob/master/examples/.
  #
  # A task for killing all workers on the machine (`rake workers:killall`) is also provided,
  # for pruning orphaned workers etc.
  #
  # NOTE: There are couple of reasons why we needed something like this and didn't
  #       find it provided for in Resque.
  #
  #       First, we wanted to have one single Rake task to launch multiple workers
  #       in production _and_ in development. This was inspired by the bundled
  #       `rake resque:workers` task.
  #
  #       Second, we wanted operations guys to simply guarantee that this Rake task
  #       is running and that's all. We would rather configure and tune everything
  #       (like the number of workers) inside the task, then bother them.
  #
  #       Third, we wanted an easy way how to very easily launch multiple workers
  #       in production (on sudden spikes in jobs, etc), just by SSH-ing
  #       to the box and running the "one and only" task.

  desc "Start all Magnum CI queues"
  task :magnum_ci do
    `nohup rake workers:start COUNT=1 QUEUE=build > log/workers.log 2>&1 &`
    `nohup rake workers:start COUNT=2 QUEUE=clone > log/workers.log 2>&1 &`
    `nohup rake workers:start COUNT=2 QUEUE=delete > log/workers.log 2>&1 &`
  end

  desc "Run and manage group of Resque workers with some default options"
  task :start => :environment do

    def Process.exists?(pid)
      kill(0, pid.to_i) rescue false
    end

    def pid_directory
      @pid_directory ||= Rails.root.join('tmp', 'pids', "resque")
    end

    def main_group_master_pid
      File.read pid_directory.join('master.pid').to_s rescue nil
    end

    def main_group?
      !main_group_master_pid || main_group_master_pid.to_s == Process.pid.to_s
    end

    def main_group_running?
      Process.exists?(main_group_master_pid)
    end

    def kill_worker(pid)
      Process.kill("QUIT", pid)
      puts "Killed worker with PID #{pid}"
    rescue Errno::ESRCH => e
      puts " STALE worker with PID #{pid}"
    end

    def kill_workers
      @pids.each { |pid| kill_worker(pid) }
    end

    def kill_workers_and_remove_pids_for_main_group
      Dir.glob(pid_directory.join('worker_*.pid').to_s) do |pidfile|
        begin
          pid = pidfile[/(\d+)\.pid/, 1].to_i
          kill_worker(pid)
        ensure
          FileUtils.rm pidfile, :force => true
        end
      end
      FileUtils.rm pid_directory.join('master.pid').to_s if main_group_master_pid
    end

    def shutdown
      puts "\n*** Exiting"
      if main_group?
        kill_workers_and_remove_pids_for_main_group
      else
        kill_workers
      end
      exit(0)
    end

    # Clean up after dead main group from before -- and become one
    unless main_group_running?
      puts "--- Cleaning up after previous main group (PID: #{main_group_master_pid})"
      kill_workers_and_remove_pids_for_main_group
    end

    # Handle exit
    trap('INT') { shutdown }
    trap('QUIT') { shutdown }
    trap('TERM') { shutdown }

    # - CONFIGURATION ----
    ENV['QUEUE']   ||= '*'
    ENV['COUNT']   ||= '3'
    # --------------------

    puts "=== Launching #{ENV['COUNT']} worker(s) on '#{ENV['QUEUE']}' queue(s) with PID #{Process.pid}"

    # Launch workers in separate processes, saving their PIDs
    @pids = []
    ENV['COUNT'].to_i.times do
      @pids << Process.fork { Rake::Task['resque:work'].invoke }
    end

    if main_group?
      # Make sure we have directory for pids
      FileUtils.mkdir_p pid_directory.to_s
      # Create PID files for workers
      File.open(pid_directory.join("master.pid").to_s, 'w') do |f|
        f.write Process.pid
      end
      @pids.each do |pid|
        File.open(pid_directory.join("worker_#{pid}.pid").to_s, 'w') { |f| f.write pid }
      end
      # Stay in foreground, if any of our workers dies, we'll get killed so Monit/God etc can come to the resq^Hcue
      Process.wait
    else
      # Stay in foreground, if any of our workers dies, continue running
      Process.waitall
    end
  end

  desc "Kill ALL workers on this machine"
  task :killall do
    require 'resque'
    Resque::Worker.all.each do |worker|
      puts "Shutting down worker #{worker}"
      host, pid, queues = worker.id.split(':')
      Process.kill("QUIT", pid.to_i)
    end
  end

end
