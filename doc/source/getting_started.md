## Build an online shop using nimbleShop ##

Please follow this documentation if you are using _nimbleShop_. If you are developing _nimbleshop_ , the framework itself, then follow [setting up development environment][1].

### nimbleShop only supports ruby 1.9.2+ ###

In order to get started with nimbleShop you need to have

* ruby 1.9.2+
* rails 3.2.9

### Building myshop using nimbleShop ###

```shell
rails new myshop
```

Open <ins>Gemfile</ins> and add following two lines

```shell
gem 'nimbleshop', '~> 0.0.20'
gem 'nimbleshop_simply', '~> 0.0.20'
```

<ins>nimbleshop_simply</ins> is the theme that we are using here.

Next execute following commands:

```shell
bundle install

bundle exec rails generate nimbleshop:install

bundle exec rake nimbleshop:setup:db

bundle exec rails server
```

Now visit [http://localhost:3000][2] and you should see your shop.

Access admin page by visiting [http://localhost:3000/admin][3].

[1]: http://nimbleshop.org/setting_up_development_environment.html
[2]: http://localhost:3000
[3]: http://localhost:3000/admin
