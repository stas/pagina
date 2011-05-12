require 'dalli'

module Pagina
  class Cache
    attr_reader :dalli
    def initialize
      @dalli = nil
      @config = Pagina::Config.new
      try_memcache
    end
    
    def try_memcache
      if !@config.memcache_ip.nil?
        @dalli = Dalli::Client.new(
          @config.memcache_ip, 
            :username => @config.memcache_user, 
            :password => @config.memcache_pass, 
            :expires_in => 300
          )
      end
    end
  end
end
