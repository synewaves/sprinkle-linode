CONFIGS_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'apache', 'configs'))

package :apache do
  describe 'Apache web server'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-prefork-dev libapr1-dev apache2-utils libexpat1 ssl-cert' do
    post :install,
      'a2enmod expires',
      'a2enmod headers',
      'a2enmod rewrite',
      'a2dissite default',
      'rm -fr /etc/apache2/sites-available/*',
      'rm -fr /var/www/*',
      'cd /var/www && chown -R www-data:www-data . && chmod g+s .',
      'sed -i "s|^ServerSignature .*$|ServerSignature Off|" /etc/apache2/conf.d/security',
      'sed -i "s|^ServerTokens .*$|ServerTokens Prod|" /etc/apache2/conf.d/security',
      'sed -i "s|^HostnameLookups .*$|HostnameLookups Off|" /etc/apache2/conf.d/security'

    post :install, '/etc/init.d/apache2 restart'
  end

  verify do
    has_process 'apache2'
  end
end

package :apache_configuration do
  describe 'Apache configuration files'
  
  Dir["#{CONFIGS_PATH}/*"].each do |config|
    name = File.basename(config)
    transfer config, "/etc/apache2/conf.d/#{name}"
  end
  
  requires :apache
  
  verify do
    Dir["#{CONFIGS_PATH}/*"].each do |config|
      name = File.basename(config)
      has_file "/etc/apache2/conf.d/#{name}"
    end
  end
end
