require 'packages/apache'
require 'packages/essential'
require 'packages/gems'
require 'packages/git'
require 'packages/mongodb'
require 'packages/monit'
require 'packages/mysql'
require 'packages/passenger'
require 'packages/ruby'

policy :linode, :roles => :app do
  requires :build_essential
  requires :apache
  requires :apache_configuration
  requires :database
  requires :gems
  requires :monitoring
  requires :passenger
  requires :ruby
  requires :scm
end

deployment do
  delivery :capistrano

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
