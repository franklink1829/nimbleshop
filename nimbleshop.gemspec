# Encoding: UTF-8

version = File.read(File.expand_path("../NIMBLESHOP_VERSION", __FILE__)).strip
rails_version = '3.2.11'

Gem::Specification.new do |gem|

  gem.name              = 'nimbleshop'
  gem.version           = version
  gem.authors           = ['Neeraj Singh', 'megpha']
  gem.email             = 'neeraj@BigBinary.com'
  gem.homepage          = 'http://nimbleShop.org'

  gem.summary           = 'nimbleShop gem is a free and open source e-commerce framework based on ruby on rails'
  gem.description       = 'nimbleShop is a free and open source e-commerce framework based on ruby on rails'

  gem.files = Dir['{lib}/**/*'] + ['README.md']

  gem.add_dependency 'rails', rails_version

  gem.add_dependency 'nimbleshop_core',            "= #{version}"

  gem.add_dependency 'nimbleshop_authorizedotnet', "= #{version}"
  gem.add_dependency 'nimbleshop_paypalwp',        "= #{version}"
  gem.add_dependency 'nimbleshop_cod',             "= #{version}"
  gem.add_dependency 'nimbleshop_stripe',          "= #{version}"
end
