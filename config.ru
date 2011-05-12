require 'bundler/setup'

Bundler.require

$LOAD_PATH.unshift(::File.expand_path('lib', ::File.dirname(__FILE__)))
require 'pagina/app'

run Pagina::App