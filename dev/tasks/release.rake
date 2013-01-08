#
# This file is responsible for releasing newer version of nimbleshop gems.
# Here is the order in which it should be executed.
#
#
# Change the version number in NIMBLESHOP_VERSION file.
# Change the version number in nimbleshop_simply.gemspec file under nimbleshop_simply repo.
#
# rake nimbleshop:package_all
# rake nimbleshop:bundle_all
# git commit any changes to Gemfile and Gemfile.lock
# rake nimbleshop:release_all
#
require 'rake'

default_pkg_dir = File.expand_path('../../pkg', __FILE__)
version = File.read(File.expand_path("../../../NIMBLESHOP_VERSION", __FILE__)).strip

class Gemm
  attr_accessor :extension_name, :gem_filename, :gemspec, :pkg_dir, :version, :extension_dir

  def initialize(extension, pkg_dir, version, extension_dir)
    @extension_name = extension
    @gem_filename = "pkg/#{extension}-#{version}.gem"
    @gemspec = "#{extension_name}.gemspec"
    @pkg_dir = pkg_dir
    @version = version
    @extension_dir = extension_dir
  end

  def clean
    FileUtils.mkdir_p pkg_dir unless File.exists? pkg_dir
    FileUtils.rm_f gem_filename
  end

  def build
    cmd = ''
    cmd << "cd #{extension_dir.expand_path.to_s} && " if extension_name != 'nimbleshop'
    cmd << "gem build #{gemspec} && "
    cmd << "mv #{extension_name}-#{version}.gem #{pkg_dir}/"
    puts cmd
    system cmd
  end

  def install
    cmd = "cd #{pkg_dir} && gem install #{extension_name}-#{version}.gem"
    puts cmd
    system cmd
  end

  def bundle
    ENV['BUNDLE_GEMFILE'] = File.expand_path("../../../#{extension_dir}/Gemfile", __FILE__)
    cmd = "cd #{extension_dir} && bundle install"
    puts cmd
    system cmd
  end

  def release_gem
    cmd = "cd #{pkg_dir} && gem push #{extension_name}-#{version}.gem"
    puts cmd
    system cmd
  end
end

engines = %w(simply core stripe authorizedotnet paypalwp cod).map { |i| "nimbleshop_#{i}" }
all = engines + ['nimbleshop']

main = ['nimbleshop_core', 'nimbleshop']
main.each do |extension|
  namespace extension do
    gem = Gemm.new(extension, default_pkg_dir, version, Pathname.new(extension))
    task :clean do
      gem.clean
    end
    task :build do
      gem.build
    end
    task :install do
      gem.install
    end
    task :bundle do
      gem.bundle
    end
    task :release_gem do
      gem.release_gem
    end
    task :package => [:clean, :build, :install]
    task :release => [:package, :release_gem]

    if extension == 'nimbleshop_core'
      desc 'Tag the release'
      task :tag_the_release do
        cmd = "git tag -a v#{version} -m 'version  #{version} '"
        sh cmd
        cmd = "git push --tags"
        sh cmd
      end
    end

  end
end


themes = ['nimbleshop_simply']
themes.each do |extension|
  namespace extension do
    path = Pathname.new(extension).join('..', '..', 'nimbleshop_simply')
    gem = Gemm.new(extension, default_pkg_dir, version, path)
    task :clean do
      gem.clean
    end
    task :build do
      gem.build
    end
    task :install do
      gem.install
    end
    task :bundle do
      gem.bundle
    end
    task :release_gem do
      gem.release_gem
    end
    task :package => [:clean, :build, :install]
    task :release => [:package, :release_gem]

    task :tag_the_release do
      Dir.chdir(path) do
        cmd = "git tag -a v#{version} -m 'version  #{version} '"
        sh cmd
        cmd = "git push --tags"
        sh cmd
      end
    end

  end
end

payment_methods = ['nimbleshop_stripe', 'nimbleshop_authorizedotnet', 'nimbleshop_paypalwp', 'nimbleshop_cod']
payment_methods.each do |extension|
  namespace extension do
    gem = Gemm.new(extension, default_pkg_dir, version, Pathname.new(extension))
    task :clean do
      gem.clean
    end
    task :build do
      gem.build
    end
    task :install do
      gem.install
    end
    task :bundle do
      gem.bundle
    end
    task :release_gem do
      gem.release_gem
    end
    task :package => [:clean, :build, :install]
    task :release => [:package, :release_gem]
  end
end


namespace :nimbleshop do

  desc 'Packages nimbleshop and other extensions as a gem'
  task package_all: all.map { |e| "#{e}:package" }

  desc 'Runs bundle install on nimbleshop and other extensions'
  task bundle_all: engines.map { |e| "#{e}:bundle" }

  desc 'Releases nimbleshop and other extensions as a gem'
  task release_all: (all.map { |e| "#{e}:release" } << "nimbleshop:tag_the_release")

  desc 'Tag the release'
  task tag_the_release: ["nimbleshop_core:tag_the_release", "nimbleshop_simply:tag_the_release"]
end
