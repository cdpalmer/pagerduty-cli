require "pagerduty_cli/client"
require "pagerduty_cli/helper"
require "pagerduty_cli/user"
require "thor"

module PagerdutyCli
  class Error < StandardError; end
  
  class CLI < Thor
    include PagerdutyCli::Helper
    default_task :help
    attr_reader :client

    def self.exit_on_failure?
      true
    end

    desc "users", "List all users"
    def users
      initialize_client
      users = @client.get_users
      print_to_user("Found users:", :yellow)
      users.each do |user|
        print_to_user("  - #{user.name}", :cyan)
      end
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
      @client = PagerdutyCli::Client.new(ENV["PD_API_TOKEN"])

      print_to_user("Setup successful.", :green)
      puts
    end
  end
end
