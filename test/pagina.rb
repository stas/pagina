describe Pagina do
  # We gonna test some urls
  behaves_like :rack_test

  before do
    
  end

  should 'respond with a 200' do
    get '/'
    last_response.should.be.ok
    last_response !=~ /#{Pagina.e404_message}/
  end

  should 'respond with a 404' do
    get '/wrong-url'
    last_response.status.should.equal 404
    last_response =~ /#{Pagina.e404_message}/
  end

  should 'log to stdout' do
    Pagina.logger.instance_variable_get('@logdev').dev.class.should.equal File
  end

  should 'use no cache' do
    Pagina.cache.should.be.false
  end

  should 'load and use cache' do
    Pagina.cache  Dalli::Client.new
    Pagina.cache.class.should.equal Dalli::Client
    get '/'
    title = Pagina.cache.get('index')
    title = title.split("\n")
    last_response.body =~ /&mdash; #{title}<\/title>/
  end

end #Describe
