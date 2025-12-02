require "colorize"

module PagerdutyCli
  module Helper
    def print_to_user(message, color = :default)
      puts message.colorize(color)
    end
  end
end
