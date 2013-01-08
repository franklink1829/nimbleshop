eval(File.read(Pathname.new(File.dirname(__FILE__)).join('dev', 'common_gemfile.rb').to_s))

gemspec

p =  Pathname.new(File.dirname(__FILE__)).join('..', 'nimbleshop_simply')
if p.exist?
  gem 'nimbleshop_simply',           path: './../nimbleshop_simply'
else
  gem 'nimbleshop_simply',           git: 'git://github.com/nimbleshop/nimbleshop_simply.git'
end

gem 'nimbleshop_paypalwp',         path: './nimbleshop_paypalwp'
gem 'nimbleshop_authorizedotnet',  path: './nimbleshop_authorizedotnet'
gem 'nimbleshop_cod',              path: './nimbleshop_cod'
gem 'nimbleshop_stripe',           path: './nimbleshop_stripe'

gem 'railties'
