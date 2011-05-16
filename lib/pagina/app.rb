require 'rubygems'
require 'sinatra/base'

require 'pagina/config'
require 'pagina/sitemap'
require 'pagina/page'

module Pagina
  class App < Sinatra::Base
    set :app_file, nil
    set :root, Proc.new { app_file && File.expand_path('../../', File.dirname(app_file)) }
    set :views, Proc.new { root && File.join(root, 'views') }
    set :public, Proc.new { root && File.join(root, 'public') }
    set :config, Proc.new { root && File.join(root, 'config') }
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
