module Pagina
  ##
  # Default App to be started
  class App

    ##
    # App builder
    def self.start
      apps = []
      if File.exists? Pagina.public_folder.to_s 
        apps << Pagina::Assets.new
        Pagina.logger.info("Public folder set to #{Pagina.public_folder}")
      end
      apps << Pagina::Pages.new
      Rack::Cascade.new apps
    end

  end #App
end #Pagina
