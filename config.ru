dirname = File.expand_path(File.dirname(__FILE__)) + "/lib"
$LOAD_PATH.unshift(dirname) unless $LOAD_PATH.include?(dirname)

require 'tictactoe/web/app'

run Tictactoe::Web::App.new
