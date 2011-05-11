require 'maruku'

module Pagina
  class Page
    attr_reader :title, :content
    
    def initialize(name)
      sitemap = Pagina::Sitemap.new
      page_name = name.to_s + '.txt'
      page = sitemap.find(page_name)
      if !page.nil?
        @title = page[:content].split('\n')[0]
        @content = page[:content]
      end
    end
    
    def body_html
      Maruku.new(@content).to_html
    end
    
  end
end
