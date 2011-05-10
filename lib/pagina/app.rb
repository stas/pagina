require 'sinatra/base'
#require 'maruku'

require File.expand_path('page', File.dirname(__FILE__))

module Pagina
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', File.dirname(__FILE__))
    
    get '/' do
      redirect '/index'
    end
    
    get '/:name' do
      #@page = Pagina::Page.find(:name)
      #raise Sinatra::NotFound if @page.nill?
      erb :page
    end
    
  end
end
