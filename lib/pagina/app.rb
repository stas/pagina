module Pagina
  ##
  # Default App to be started
  class App

    def call(env)
      request = Rack::Request.new(env)
      name = request.path_info[1..-1] # Get rid of first slash
      name = 'index' if name.empty?
      Pagina.logger.info("New page request: #{name}")

      p = Pagina::Page.new(name) || Pagina.e404_message
      page_layout = ERB.new File.open(Pagina.layout).read

      @site_name = Pagina.title
      @site_description = Pagina.description
      @content = p.content || Pagina.e404_message
      @title = p.title || Pagina.e404_message
      [
        p.title.nil? ? 404 : 200,
        {"Content-Type" => Pagina.content_type},
        [page_layout.result(binding)]
      ]
    end

  end #App
end #Pagina
