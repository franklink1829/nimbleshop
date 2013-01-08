Dir[ File.expand_path('dev/tasks/**/*',File.dirname(__FILE__)) ].each do |task|
  load task
end

engines = %w(nimbleshop_core)
payment_methods = %w(nimbleshop_authorizedotnet nimbleshop_paypalwp nimbleshop_stripe)

desc 'Run all tests by default'
task :default => %w(test)

%w(test).each do |task_name|
  desc "Run #{task_name} task for all engines"
  task task_name do
    errors = []

    engines.each do |engine|
      system(%(cd #{engine} && #{$0} #{task_name})) || errors << engine
    end

    payment_methods.each do |engine|
      system(%(cd #{engine} && #{$0} #{task_name})) || errors << engine
    end

    fail("Errors in #{errors.join(', ')}") unless errors.empty?
  end
end
