namespace :jobs do
  desc "Clear the delayed_job queue."
#  task :clear => :environment do
#    Delayed::Job.delete_all
#  end

  desc "Alias for :clear:all"
  task :clear => :"clear:all"

  namespace :clear do
    
    desc "Clear the whole delayed_job queue."
    task :all => :environment do
      Delayed::Job.delete_all
    end
    
    desc "Clear finished jobs."
    task :finished => :environment do
      Delayed::Job.delete_all('finished_at IS NOT NULL')
    end

    desc "Clear failed jobs."
    task :failed => :environment do
      Delayed::Job.delete_all('failed_at IS NOT NULL')
    end
  end

  desc "Start a delayed_job worker."
  task :work => :environment do
    Delayed::Worker.new(:min_priority => ENV['MIN_PRIORITY'], :max_priority => ENV['MAX_PRIORITY'], :queues => (ENV['QUEUES'] || ENV['QUEUE'] || '').split(','), :quiet => false).start
  end
end
