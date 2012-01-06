module Pagina
  
  ##
  # Class to handle public directory file serving
  class Assets

    ##
    # Assets constructor
    # Loads the public folder to be served
    def initialize
      @file = Rack::File.new(Pagina.public_folder)
    end

    ##
    # Requests handler
    def call(env)
      status, header, body = @file.call(env)
    end

  end #Assets
end #Pagina
