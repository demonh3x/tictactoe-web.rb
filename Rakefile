task :default => ["run"]

task :run do
  sh 'bundle exec rackup'
end

namespace :spec do
  task :develop do
    sh 'bundle exec rspec spec/'
  end

  task :ci do
    sh 'bundle exec rspec --color -fd spec/'
  end
end
