package :git, :provides => :scm do
  description 'Git version control client'
  version '1.7.3.1'
  source "http://kernel.org/pub/software/scm/git/git-#{version}.tar.gz"
  requires :git_dependencies

  verify do
    has_executable 'git'
  end
end

package :git_dependencies do
  description 'Git build dependencies'
  apt 'git-core curl'
end
