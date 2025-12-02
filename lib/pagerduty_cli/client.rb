require "json"
require "net/http"

module PagerdutyCli
  class Client
    class << self
      def http_get(url)
        uri = URI(url)

        request = Net::HTTP::Get.new(uri)
        request["User-Agent"] = "Mozilla/5.0"

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        response.body
      end

      # def json_to_map(json_string)
      #   JSON.parse(json_string)
      # end

      # def get_input_line
      #   STDIN.gets.chomp
      # end
    end
  end
end
