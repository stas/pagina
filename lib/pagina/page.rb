module Pagina

  ##
  # Page Handler class
  class Page

    attr_accessor :content, :title

    ##
    # Page Constructor
    #
    # @param [String] name, the requested page
    def initialize(name)
      @name = name
      @content = nil
      @title = nil
      @page_path = Pagina.dropbox_url +
        Pagina.dropbox_id.to_s + '/' +
        Pagina.dropbox_folder + '/' +
        name + 
        (!Pagina.page_extension.empty? ? Pagina.page_extension : '')
      
      enable_cache if Pagina.cache == true

      raw_page = build
      @title = raw_page.split("\n")[0] if !raw_page.nil?
      @content = Kramdown::Document.new(raw_page).to_html if !raw_page.nil?
    end

    ##
    # Enables caching
    def enable_cache
      Pagina.memcache_servers ENV['MEMCACHE_SERVERS'].split(' ') if !ENV['MEMCACHE_SERVERS'].nil?
      Pagina.memcache_user ENV['MEMCACHE_USERNAME'] if !ENV['MEMCACHE_USERNAME'].nil?
      Pagina.memcache_password ENV['MEMCACHE_PASSWORD'] if !ENV['MEMCACHE_PASSWORD'].nil?
      Pagina.cache Dalli::Client.new(
        Pagina.memcache_servers,
        :username => Pagina.memcache_user,
        :password => Pagina.memcache_password
      )
      Pagina.logger.info('Caching client started')
    end

    ##
    # Try to build the page response
    # If caching is set, it will be asked from cache
    #
    # @return [String], the raw page content
    def build
      result = nil
      if Pagina.cache != false
        result = Pagina.cache.get(@name)
        Pagina.logger.info("Page loaded from cache: #{@name}")
      end
      
      !result.nil? ? result : request_page
    end

    ##
    # Try to request page data and format it to HTML
    # If caching is set, the page content cache will be updated
    #
    # @return [String], the raw page content
    def request_page
      page_data = nil
      begin
        page_request = open(@page_path)
        if page_request.status[0].to_i == 200
          page_data = page_request.string
        end
      rescue OpenURI::HTTPError
        Pagina.logger.info("Error trying to fetch: #{@name}")
        return nil
      end

      if Pagina.cache != false and !page_data.nil?
        Pagina.cache.add(@name, page_data)
        Pagina.logger.info("Page cached: #{@name}")
      else
        Pagina.logger.info("Page served uncached: #{@name}")
      end
      page_data
    end

  end #Page
end # Pagina
