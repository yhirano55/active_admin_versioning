require "rubygems"
require "bundler/setup"

$: << File.join(File.dirname(__FILE__), "..", "lib")
require "rspec"
require "pry"
require "active_admin_versioning"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
  end

  config.order = :random
end
