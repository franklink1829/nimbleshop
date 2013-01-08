require 'pathname'
require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'

module Nimbleshop
  class InstallGenerator < Rails::Generators::Base

    source_root Pathname.new(File.expand_path('../templates', __FILE__))

    def generate
      copy_nimbleshop_yml_file
      copy_initializer_files
      copy_default_gravatar_image

      ensure_no_mass_protection

      copy_migration_files
      execute_db_create
      execute_db_migrate
      execute_db_test_prepare

      mount_engines_for_routing
      delete_public_index_html
      delete_test_dir
    end


    protected

    def delete_test_dir
      FileUtils.rm_rf destination_path.join('test')
    end

    def delete_public_index_html
      remove_file "public/index.html"
    end

    def mount_engines_for_routing
      if (routes_file = destination_path.join('config', 'routes.rb')).file?
        mount = %Q{
          mount NimbleshopSimply::Engine,          at: '/', as: 'main_theme'

          mount NimbleshopAuthorizedotnet::Engine, at: '/nimbleshop_authorizedotnet'
          mount NimbleshopPaypalwp::Engine,        at: '/nimbleshop_paypalwp'
          mount NimbleshopCod::Engine,             at: '/nimbleshop_cod'
          mount NimbleshopStripe::Engine,          at: '/nimbleshop_stripe'
        }

        inject_into_file 'config/routes.rb', mount, :after => "Application.routes.draw do\n"
      end
    end

    def ensure_no_mass_protection
      file = 'config/application.rb'
      current = 'config.active_record.whitelist_attributes = true'
      new = 'config.active_record.whitelist_attributes = false'
      gsub_file file, current, new, verbose: true
    end

    def copy_migration_files
      say_status :copying, "migration files"
      silence_stream(STDOUT) do
        silence_warnings { rake 'railties:install:migrations' }
      end
    end

    def execute_db_test_prepare
      say_status :running, "db:test:prepare"
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          silence_warnings { rake 'db:test:prepare' }
        end
      end
    end

    def execute_db_create
      say_status :running, "db:create"
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          silence_warnings { rake 'db:create' }
        end
      end
    end

    def execute_db_migrate
      say_status :running, "db:migrate"
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          silence_warnings { rake 'db:migrate' }
        end
      end
    end


    def bundle!
      run 'bundle install'
    end

    def copy_initializer_files
      template "config/initializers/001_load_nimbleshop_config.rb", "#{destination_path}/config/initializers/001_load_nimbleshop_config.rb"
      template "config/initializers/cache_images.rb", "#{destination_path}/config/initializers/cache_images.rb"
      template "config/initializers/carrierwave.rb",  "#{destination_path}/config/initializers/carrierwave.rb"
      template "config/initializers/delayed_job.rb",  "#{destination_path}/config/initializers/delayed_job.rb"
      template "config/initializers/setup_email.rb",  "#{destination_path}/config/initializers/setup_email.rb"
    end

    # Helper method to quickly convert destination_root to a Pathname for easy file path manipulation
    def destination_path
      @destination_path ||= Pathname.new(self.destination_root)
    end

    # do not use template method to copy the file. template method actually executes the code
    #  <%= ENV['S3_ACCESS_KEY_ID'] %> inside nimbleshop.yml rather than copying that code
    def copy_nimbleshop_yml_file
      from = File.expand_path('../templates/config/nimbleshop.yml', __FILE__)
      FileUtils.cp from,  "#{destination_path}/config/nimbleshop.yml"
    end

    # TODO this should be in assets folder but it was not working so I put it here so that
    # it can be copied  over to the main rails application
    def copy_default_gravatar_image
      from = File.expand_path('../templates/assets/default_gravatar.jpg', __FILE__)
      FileUtils.cp from,  "#{destination_path}/app/assets/images/default_gravatar.jpg"

    end

  end
end
