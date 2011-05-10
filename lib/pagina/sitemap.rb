module Pagina
  class Sitemap
    def initialize
      config = Pagina::Config.new
      @dropbox_id = config.dropbox_id
      @dropbox_path = config.dropbox_path
      self.populate
    end
    
    def populate
      # TODO, load pages from Dropbox
    end
    
    def find(name)
      nil
    end
  end
end