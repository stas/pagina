require 'yaml'

module Pagina
  class Config
    
    attr_accessor :settings, :yaml_data
    
    def initialize
      @settings = %w[
        name description dropbox_id dropbox_path dropbox_url memcache_ip memcache_user memcache_pass
      ]
      
      yaml_path = File.expand_path('pagina.yaml', config)
      
      if File.exist?(yaml_path)
        @yaml_data ||= YAML::load(IO::read(yaml_path))
      else
        return nil
      end
    end
    
    def method_missing(method, *args)
      name = method.to_s
      if @settings.include?(name)
        if !@yaml_data.nil?
          @yaml_data[name]
        end
      else
        nil
      end
    end
    
  end
end
