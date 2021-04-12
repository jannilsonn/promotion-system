ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start 'rails' do
    add_filter 'jobs'
    add_filter 'mailers'
  end
end

require_relative '../config/environment'
require 'rails/test_help'

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

class ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include Warden::Test::Helpers
  include LoginJane
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  if ENV['COVERAGE']
    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
    end

    parallelize_teardown do
      SimpleCov.result
    end
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end
