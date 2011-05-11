require 'open-uri'

module Pagina
  class Sitemap
    def initialize
      config = Pagina::Config.new
      @dropbox_id = config.dropbox_id
      @dropbox_path = config.dropbox_path
      @dropbox_url = config.dropbox_url
      @pages = {} # TODO: Load this from memcache
    end
    
    def load_page(name)
      file_uri = @dropbox_url + @dropbox_id.to_s + @dropbox_path + name
      request = open(file_uri)
      if request.status[0].to_i == 200
        @pages[name] = {
          :content => request.string,
          :last_modified => request.meta['date']
        }
      end
    end
    
    def find(name)
      if @pages.include? name
        @pages[name]
      else
        load_page(name)
      end
    end
  end
end