##
# Our own namespace
module Pagina
  
  require 'erb'
  require 'open-uri'
  require 'logger'
  require 'kramdown'
  require 'dalli'

  VERSION = '0.2'
  ROOT    = File.dirname __FILE__

  $LOAD_PATH.unshift(Pagina::ROOT)
  require 'pagina/app'
  require 'pagina/page'


  class << self
    attr_accessor :options
  end
  @options = {
    'title'             => 'Default Pagina Title',
    'description'       => 'Default Pagina Description',
    'dropbox_url'       => 'http://dl.dropbox.com/u/',
    'dropbox_id'        => 'Your DropBox ID comes here',
    'dropbox_folder'    => 'Your DropBox folder to be used for app',
    'page_extension'    => '.txt',
    'cache'             => false,
    'memcache_servers'  => ['An array of server IP:PORTs'],
    'memcache_user'     => 'Your memcache user',
    'memcache_password' => 'Your memcache password',
    'layout'            => 'Full path to your layout file',
    'content_type'      => 'text/html',
    'e404_message'      => 'Sorry, not found!',
    'logger'            => Logger.new(STDOUT)
  }

  ##
  # Enables caching
  def self.enable_cache
    Pagina.memcache_servers ENV['MEMCACHE_SERVERS'].split(' ') if !ENV['MEMCACHE_SERVERS'].nil?
    Pagina.memcache_user ENV['MEMCACHE_USERNAME'] if !ENV['MEMCACHE_USERNAME'].nil?
    Pagina.memcache_password ENV['MEMCACHE_PASSWORD'] if !ENV['MEMCACHE_PASSWORD'].nil?
    @options['cache'] = Dalli::Client.new(
      Pagina.memcache_servers,
      :username => Pagina.memcache_user,
      :password => Pagina.memcache_password
    )
    Pagina.logger.info('Caching client started')
  end

  ##
  # Simple wrapper to ease access to our @options
  # If an argument is passed, the old value will be re-written
  def self.method_missing(method, *args)
    key = method.to_s
    new_value = args.first
    if @options.include? key
      @options[key] = new_value if !new_value.nil?
      # If caching value changed, try to enable caching
      enable_cache if key == 'cache' and new_value == true
      return @options[key]
    else
      super
    end
  end

end #Pagina
