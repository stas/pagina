# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name            = 'pagina'
  s.version         = '0.1'
  s.platform        = Gem::Platform::RUBY
  s.summary         = "Pagina will generate a personal website."
  s.description     = "Pagina is a Sinatra web app that will use your Dropbox folder for pages."
  
  s.author          = "Stas Sușcov"
  s.email           = "stas@nerd.ro"
  s.homepage        = "http://stas.nerd.ro"
  
  s.files           = `git ls-files -- {bin,lib,spec}/*`.split("\n")
  s.require_paths   = ['lib']
  
  s.add_dependency('maruku', '>= 0.6.0')
  s.add_dependency('sinatra', '1.1.2')
  s.add_dependency('dalli')
end