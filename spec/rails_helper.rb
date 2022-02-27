unless ENV["SKIP_COVERAGE"]
  require 'simplecov'
  require 'simplecov-console'

  SimpleCov.minimum_coverage 100
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Console
    ]
  )

  SimpleCov.start 'rails' do
    add_filter "app/mailers/application_mailer.rb"
    add_filter "app/channels/application_cable/channel.rb"
    add_filter "app/jobs/application_job.rb"
    add_filter "app/channels/application_cable/connection.rb"
  end
end

require_relative File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.full_backtrace = true

  config.before :each do
    Rails.cache.clear
  end
end
