package :gems do
  description 'Gems for Ruby'

  gem 'bundler mysql rails'
  gem 'mongoid --pre'
  gem 'bson_ext'

  requires :ruby
  requires :rubygems

  verify do
    ruby_can_load 'bundler'
    ruby_can_load 'mysql'
  end
end
