require 'sinatra/base'

require File.expand_path('page', File.dirname(__FILE__))

module Pagina
  class App < Sinatra::Base
    set :views, File.expand_path('../../views', File.dirname(__FILE__))
    
    get '/' do
      redirect '/index'
    end
    
    get '/:name' do
      @page = Pagina::Page.new(:name)
      raise Sinatra::NotFound if @page.nil?
      erb :page
    end
    
  end
end
