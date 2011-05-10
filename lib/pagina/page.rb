module Pagina
  class Page
    attr_reader :title, :content
    
    def self.find(name)
      @title = 'Test Title'
      @content = 'Test Content'
    end
    
  end
end
