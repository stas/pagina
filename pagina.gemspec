# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name              = 'pagina'
  s.version           = '0.2'
  s.platform          = Gem::Platform::RUBY
  s.summary           = "Pagina will generate a personal website for you using a Dropbox folder."
  s.description       = "Pagina is a small and light web app that uses your Dropbox folder for site pages."
  
  s.author            = "Stas Sușcov"
  s.email             = "stas@nerd.ro"
  s.homepage          = "https://github.com/stas/pagina"
  s.rubyforge_project = s.name
  
  s.files             = `git ls-files`.split("\n")
  s.require_paths     = ['lib']
  
  s.add_runtime_dependency('rack')
  s.add_runtime_dependency('kramdown')
  s.add_runtime_dependency('dalli')

  s.add_development_dependency('rake')
  s.add_development_dependency('bacon')
end
