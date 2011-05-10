require 'sinatra/base'

require File.expand_path('config', File.dirname(__FILE__))
require File.expand_path('page', File.dirname(__FILE__))
require File.expand_path('sitemap', File.dirname(__FILE__))

module Pagina
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', File.dirname(__FILE__))
    
    helpers do
      def load_config
        config = Pagina::Config.new
        @site_name = config.name
        @site_description = config.description
      end
    end
    
    get '/' do
      redirect '/index'
    end
    
    get '/:name' do
      load_config
      @page = Pagina::Page.new(:name)
      raise Sinatra::NotFound if @page.nil?
      erb :page
    end
    
  end
end
