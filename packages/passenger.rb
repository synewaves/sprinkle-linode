package :passenger do
  description 'Passenger (mod_rails) Apache extension'
  requires :apache, :ruby
  version '2.2.15'
  gem 'passenger' do
    post :install,
      'echo -en "\n\n\n\n" | passenger-install-apache2-module',
      'touch /etc/apache2/conf.d/passenger.conf'

   ["LoadModule passenger_module /usr/local/lib/ruby/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so",
    "PassengerRoot /usr/local/lib/ruby/gems/1.8/gems/passenger-#{version}",
    "PassengerRuby /usr/local/bin/ruby"].each do |line|
      post :install, "echo '#{line}' >> /etc/apache2/conf.d/passenger.conf"
    end

    post :install, '/etc/init.d/apache2 restart'
  end

  verify do
    has_file '/etc/apache2/conf.d/passenger.conf'
    has_file "/usr/local/lib/ruby/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so"
  end
end
