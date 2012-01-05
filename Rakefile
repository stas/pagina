require 'rake'
require 'rake/clean'

CLEAN.include %w[
  pagina.log
]

desc "Run all the tests"
task :test do
  sh "bacon test/init.rb"
end

task :default => 'test'
