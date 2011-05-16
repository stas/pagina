require 'open-uri'

require 'pagina/cache'

module Pagina
  class Sitemap
    def initialize
      config = Pagina::Config.new
      if !config.nil?
        @dropbox_id = config.dropbox_id
        @dropbox_path = config.dropbox_path
        @dropbox_url = config.dropbox_url
        @cache = Pagina::Cache.new.dalli
      else
        return nil
      end
    end
    
    def load_page(name)
      file_uri = @dropbox_url + @dropbox_id.to_s + @dropbox_path + name
      begin
        request = open(file_uri)
        if request.status[0].to_i == 200
          page = {
            :content => request.string,
            :etag => request.meta['etag']
          }
        else
          nil
        end
      rescue OpenURI::HTTPError
        nil
      end
    end
    
    def find(name)
      page = nil
      if !@cache.nil?
        page = @cache.get(name)
      end
      
      if page.nil? && !@dropbox_id.nil?
        page = load_page(name)
        if !@cache.nil?
          @cache.set(name, page)
        end
      end
      return page
    end
  end
end
