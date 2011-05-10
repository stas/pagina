require 'maruku'

module Pagina
  class Page
    attr_reader :title, :content
    
    def initialize(name)
      sitemap = Pagina::Sitemap.new
      page = sitemap.find(name)
      if !page.nil?
        @title = page.title
        @content = page.content
      else
        # temporary data
        @title = 'title'
        @content = 'content'
      end
    end
    
    def body_html
      Maruku.new(@content).to_html
    end
    
  end
end
