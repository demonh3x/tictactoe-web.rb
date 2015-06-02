require 'rspec/core/rake_task'

task :default => ["spec:develop"]

namespace :spec do
  RSpec::Core::RakeTask.new(:develop) do |task|
    task.verbose = false
  end

  RSpec::Core::RakeTask.new(:ci) do |task|
    task.rspec_opts = "--color -fd"
  end
end

task :run do
  `rackup`
end
