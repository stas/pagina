require 'rubygems'
require 'sinatra/base'

require 'pagina/config'
require 'pagina/sitemap'
require 'pagina/page'

module Pagina
  class App < Sinatra::Base
    set :root, File.expand_path( '../../', File.dirname(__FILE__) )
    set :config, File.join(root, 'config')
    set :views, File.join(root, 'views')
    set :public, File.join(root, 'public')
    set :environment, :production
    
    helpers do
      def load_config
        config_data = Pagina::Config.new
        if !config_data.nil?
          @site_name = config_data.name
          @site_description = config_data.description
        end
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
