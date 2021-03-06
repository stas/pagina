describe Pagina do
  # We gonna test some urls
  behaves_like :rack_test

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

  should 'redirect log to a file' do
    Pagina.logger.instance_variable_get('@logdev').dev.class.should.equal File
  end

  should 'use no cache' do
    Pagina.cache.should.be.false
  end

  # Skip this test if no memcache servers are set
  if !ENV['MEMCACHE_SERVERS'].nil?
    should 'load and use cache' do
      Pagina.cache true
      get '/'
      title = Pagina.cache.get('index')
      Pagina.cache.class.should.equal Dalli::Client
      title = title.split("\n")
      last_response.body =~ /&mdash; #{title}<\/title>/
    end
  end

  should 'serve static files' do
    get '/test/layout.html'
    last_response.should.be.ok
    last_response =~ /#{Pagina.layout}/
  end

end #Describe
