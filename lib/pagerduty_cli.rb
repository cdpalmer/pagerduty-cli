require "pagerduty_cli/client"
require "pagerduty_cli/helper"
require "thor"
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
        print_to_user("  #{user.id} - #{user.name}", :cyan)
      end
    end

    desc "user", "Display data on a specific user"
    def user(id)
      initialize_client
      user = @client.get_user(id)
      if user.nil?
        print_to_user("User Not Found with ID: #{id}", :red)
        exit 1
      else
        print_to_user("Found user:", :yellow)
        print_to_user("  Name - #{user.name}", :cyan)
        print_to_user("  Email - #{user.email}", :cyan)
        print_to_user("  Time Zone - #{user.time_zone}", :cyan)
        print_to_user("  Color - #{user.color}", :cyan)
        print_to_user("  Avatar URL - #{user.avatar_url}", :cyan)
        print_to_user("  Billed - #{user.billed}", :cyan)
        print_to_user("  Role - #{user.role}", :cyan)
        print_to_user("  Description - #{user.description}", :cyan)
        print_to_user("  Invitation Sent - #{user.invitation_sent}", :cyan) 
        print_to_user("  Job Title - #{user.job_title}", :cyan)
        print_to_user("  Teams - #{user.teams.map { |team| team.name }.join(", ")}", :cyan)
        print_to_user("  Created Via SSO - #{user.created_via_sso}", :cyan)
        print_to_user("  Locale - #{user.locale}", :cyan)
        print_to_user("  ID - #{user.id}", :cyan)
        print_to_user("  Type - #{user.type}", :cyan)
        print_to_user("  Summary - #{user.summary}", :cyan)
        print_to_user("  Self - #{user.self}", :cyan)
        print_to_user("  HTML URL - #{user.html_url}", :cyan)
        print_to_user("  Contact Method - #{user.contact_methods}", :cyan)
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
