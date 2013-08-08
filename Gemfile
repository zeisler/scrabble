source 'https://rubygems.org'


gem 'rails', '4.0.0'

group :development do
  gem 'sqlite3', '1.3.7', :platform => :ruby
  gem 'coffee-rails-source-maps'
  gem 'guard-livereload'
  platforms :jruby do
    # gem 'jruby-openssl'
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'trinidad', :require => nil
  end
end

gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass'
gem "font-awesome-rails", github: 'bokmann/font-awesome-rails'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor'
end

group :test, :development do
  gem 'jasmine-rails'
end

