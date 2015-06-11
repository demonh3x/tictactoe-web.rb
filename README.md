# tictactoe-web.rb
A Web interface for tictactoe

[![Travis CI](https://travis-ci.org/demonh3x/tictactoe-web.rb.svg?branch=master)](https://travis-ci.org/demonh3x/tictactoe-web.rb)
[![Code Climate](https://codeclimate.com/github/demonh3x/tictactoe-web.rb/badges/gpa.svg)](https://codeclimate.com/github/demonh3x/tictactoe-web.rb)
[![Test Coverage](https://codeclimate.com/github/demonh3x/tictactoe-web.rb/badges/coverage.svg)](https://codeclimate.com/github/demonh3x/tictactoe-web.rb/coverage)

## Description

This is a [web server][web] interface in html for [tictactoe-core.rb][core]

[web]: http://en.wikipedia.org/wiki/Web_server
[core]: https://github.com/demonh3x/tictactoe-core.rb

## Dependencies

##### Execution
* Ruby, from v2.0.0 to 2.2.0 (other versions might work too)
* [tictactoe-core.rb][core] v0.1.2
* [Rack][rack] v1.6.1

[rack]: http://rack.github.io/

##### Testing
* [RSpec][rspec] 3.1.0
* [rack-test][racktest] 0.6.3
* [nokogiri][nokogiri] 1.6.6
* [fakefs][fakefs] 0.6.7
* [Codeclimate Test Reporter][climate] (For CI environment)

[rspec]: http://rspec.info/
[racktest]: https://github.com/brynary/rack-test
[nokogiri]: http://www.nokogiri.org/
[fakefs]: https://github.com/defunkt/fakefs
[climate]: https://github.com/codeclimate/ruby-test-reporter

##### Others
* [Bundler][bundler] (To manage dependencies)
* [Rake][rake] (To run preconfigured tasks)

[bundler]: http://bundler.io/
[rake]: https://github.com/ruby/rake

## Setup

##### Install dependencies
`bundle install`

##### Run tests
`rake`

##### Run server
`rake run` or `bin/tictactoe_web` and use the port specified in stdout.

##### Deploy to heroku
`rake deploy`

## Rake tasks
run `rake -T` to see all available tasks
