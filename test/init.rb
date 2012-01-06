require 'bacon'
require 'rack/test'
require File.expand_path('lib/pagina.rb')

Bacon.summary_on_exit

shared :rack_test do
  extend Rack::Test::Methods

  # Set some Dropbox test data
  # Memcache credentials are loaded through ENV
  Pagina.dropbox_id 20301790
  Pagina.dropbox_folder 'Pagina'
  Pagina.layout File.expand_path '../test/layout.html', Pagina::ROOT
  Pagina.public_folder File.expand_path '../', Pagina::ROOT

  # Set App to be less verbose
  Pagina.logger Logger.new('pagina.log')

  # Serve the app handler
  def app; Pagina::App.start; end
end

Dir.glob('test/**/*.rb').each do |file|
  load File.expand_path(file) unless file == __FILE__
end
