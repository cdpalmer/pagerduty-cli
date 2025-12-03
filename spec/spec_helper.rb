require "bundler/setup"
require "pagerduty_cli"
require "webmock/rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
