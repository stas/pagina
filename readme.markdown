## Pagina

[![travis-ci status](https://secure.travis-ci.org/stas/pagina.png)](http://travis-ci.org/#!/stas/pagina)

>*Pagina* is a small web app that uses
a [Dropbox](http://dropbox.com) (or any other web) folder for site pages.

*Pagina* was designed to run on [Heroku](http://heroku.com).
It is very light (only hardcore dependency is `rack`) and uses Memcache to speed up pageloads.

The idea was to deploy simple homepages using latest cloud services
fast and cheap. And in the same time, spend minimum time for implementing
website design/layout.

While Dropbox takes care of ACL, revisions and hosting space, _Pagina_ uses
[Markdown](http://kramdown.rubyforge.org/quickref.html) files to render pages.

 * GitHub &rarr; https://github.com/stas/pagina
 * Example (found also below) &rarr; http://pagina-app.heroku.com/
 * MIT License

### Gems
 * [Kramdown](http://kramdown.rubyforge.org)
 * [Dalli](https://github.com/mperham/dalli) (optional)

This page [source](http://dl.dropbox.com/u/20301790/Pagina/index.txt)

### Example `config.ru`

```ruby
require 'bundler/setup'
Bundler.require

Pagina.dropbox_id 20301790
Pagina.dropbox_folder 'Pagina'
Pagina.layout File.expand_path '../test/layout.html', Pagina::ROOT
# Pagina.public_folder File.expand_path 'public' # To enable static files
run Pagina::App.start
```


### Example `Gemfile`

```ruby
source "http://rubygems.org"
gem 'dalli'
gem 'kramdown'
gem 'pagina', :git => 'git://github.com/stas/pagina.git'
```
