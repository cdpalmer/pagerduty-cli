require "pagerduty_cli/client"
require "pagerduty_cli/helper"
require "thor"

module PagerdutyCli
  class Error < StandardError; end
  
  class CLI < Thor
    include PagerdutyCli::Helper
    default_task :help

    desc "hello NAME", "say hello to NAME"
    def hello(name)
      print_to_user("Hello #{name}", :green)
    end
  end
end
