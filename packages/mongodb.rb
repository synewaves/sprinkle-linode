package :mongodb, :provides => :database do
  description 'mongoDB'
  apt 'mongodb-stable' do
    pre :install, "echo 'deb http://downloads.mongodb.org/distros/ubuntu 10.4 10gen' >> /etc/apt/sources.list"
    pre :install, "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    pre :install, 'apt-get -y update'
  end
  
  verify do
    has_executable 'mongo'
  end
end