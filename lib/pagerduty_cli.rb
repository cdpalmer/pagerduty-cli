require "pagerduty_cli/client"
require "pagerduty_cli/helper"
require "thor"

module PagerdutyCli
  class Error < StandardError; end
  
  class CLI < Thor
    include PagerdutyCli::Helper
    default_task :help

    def self.exit_on_failure?
      true
    end

    desc "hello NAME", "say hello to NAME"
    def hello(name)
      initialize_client
      print_to_user("Hello #{name}", :green)
    end

    private

    def initialize_client
      puts
      print_to_user("initializing...", :yellow)
      print_to_user("  - Verify api token is set.", :yellow)
      if ENV["PD_API_TOKEN"].nil? || ENV["PD_API_TOKEN"].empty?
        print_to_user("PD_API_TOKEN environment variable not set.", :red)
        exit 1
      end

      print_to_user("Setup successful.", :green)
      puts
    end
  end
end
