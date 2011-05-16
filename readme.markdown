## Pagina

>*Pagina* is a [Sinatra](http://www.sinatrarb.com/) web app that uses
a [Dropbox](http://dropbox.com) (or any other web) folder for site pages.

*Pagina* was designed to run on [Heroku](http://heroku.com).
It is very light and uses Memcache to speed up pageloads.

The idea was to deploy simple homepages using latest cloud services
fast and cheap. And in the same time, spend minimum time for implementing
website design/layout.

While Dropbox takes care of ACL, revisions and hosting space, _Pagina_ uses
[Markdown](http://kramdown.rubyforge.org/quickref.html) files to render pages.

 * GitHub &rarr; https://github.com/stas/pagina
 * Example (found also below) &rarr; http://pagina-app.heroku.com/
 * MIT License

### Gems
* [Sinatra](http://www.sinatrarb.com/)
* [Kramdown](http://kramdown.rubyforge.org)
* [Dalli](https://github.com/mperham/dalli) (optional)

### Example `config.ru`
<pre>
require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'pagina/app'

class PaginaApp < Pagina::App
  # Uncomment lines below to customize views and use another config file
  set :local_root, File.expand_path('./', File.dirname(__FILE__))
  set :config, File.join(local_root, './')
  #set :views, File.join(local_root, 'views')
end

run PaginaApp
</pre>

This page [source](http://dl.dropbox.com/u/20301790/Pagina/index.txt)