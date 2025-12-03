require "json"
require "net/http"

module PagerdutyCli
  class Client
    def initialize(token)
      @token = token
    end

    def http_get(url)
      uri = URI(url)

      request = Net::HTTP::Get.new(uri)
      request["User-Agent"] = "Mozilla/5.0"
      request["Authorization"] = "Token token=#{@token}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      JSON.parse(response.body)
    end

    def get_users
      response = http_get("https://api.pagerduty.com/users")
      response["users"].map do |user_data|
        User.new(user_data)
      end
    end

    def get_user(id)
      users = get_users
      users.find { |user| user.id == id }
      response = http_get("https://api.pagerduty.com/users/#{id}")
      User.new(response["user"]) if response["user"]
    end
  end
end
