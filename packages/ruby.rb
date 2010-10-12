package :ruby_enterprise, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  version '1.8.7-2010.02'
  
  deb "http://rubyforge.org/frs/download.php/71100/ruby-enterprise_#{version}_i386_ubuntu10.04.deb"
  
  verify do
    has_executable 'ruby'
  end
end

package :rubygems do
  description 'Ruby Gems Package Management System'
  version '1.3.7'
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
    custom_install 'ruby setup.rb'
    post :install, 'update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.8 1'
  end
  
  requires :ruby

  verify do
    ruby_can_load 'rubygems'
  end
end
