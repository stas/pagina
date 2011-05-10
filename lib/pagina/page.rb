require 'maruku'

module Pagina
  class Page
    attr_reader :title, :content
    
    def initialize(name)
      @title = 'Test Title'
      @content = 'Test Content'
    end
    
    def body_html
      Maruku.new(@content).to_html
    end
    
  end
end
