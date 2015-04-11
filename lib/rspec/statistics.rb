require "rspec/statistics/version"
require "rspec/statistics/listener"

RSpec.configure do |rspec|
  rspec.reporter.register_listener RSpec::Statistics::Listener.new, :start, :example_started, :example_passed, :example_failed
end

