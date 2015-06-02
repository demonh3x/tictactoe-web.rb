task :default => ["run"]

task :run do
  `rackup`
end

begin
  namespace :spec do
    require 'rspec/core/rake_task'

    RSpec::Core::RakeTask.new(:develop) do |task|
      task.verbose = false
    end

    RSpec::Core::RakeTask.new(:ci) do |task|
      task.rspec_opts = "--color -fd"
    end
  end
rescue LoadError
end
