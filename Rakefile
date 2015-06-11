task :default => ["spec:develop"]

desc 'Executes the server'
task :run do
  sh 'bundle exec rackup'
end

desc 'Adds heroku as a remote and deploys'
task :deploy do
  sh 'heroku git:remote -a demonh3x-tictactoe'
  sh 'git push heroku master'
end

namespace :spec do
  desc 'Runs all the tests that provide fast feedback'
  task :develop do
    sh 'bundle exec rspec spec/'
  end

  desc 'Runs the all the tests for continuous integration'
  task :ci do
    sh 'bundle exec rspec --color -fd spec/'
  end
end
