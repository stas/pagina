require 'rubygems'
require 'sinatra/base'

require 'pagina/config'
require 'pagina/sitemap'
require 'pagina/page'

module Pagina
  class App < Sinatra::Base
    set :app_file, __FILE__
    set :root, File.expand_path('../../', File.dirname(__FILE__))
    set :views, File.expand_path('views', App.root)
    set :public, File.expand_path('public', App.root)
    set :configs, File.expand_path('config', App.root)
    set :environment, :production
    
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
      @page = Pagina::Page.new(params[:name])
      
      raise Sinatra::NotFound if @page.title.nil?
      erb :page
    end
    
    not_found do
      load_config
      erb :'404'
    end
    
    error do
      load_config
      erb :'500'
    end
    
  end
end
