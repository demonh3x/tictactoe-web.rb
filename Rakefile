task :default => ["run"]

task :run do
  sh 'rackup'
end

namespace :spec do
  task :develop do
    sh 'rspec'
  end

  task :ci do
    sh 'rspec --color -fd'
  end
end
