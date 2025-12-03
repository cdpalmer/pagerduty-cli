require "spec_helper"
require "pagerduty_cli/client"
require "pagerduty_cli/user"

RSpec.describe PagerdutyCli::Client do
  let(:token) { "test-token" }
  let(:client) { described_class.new(token) }

  describe "#get_users" do
    before do
      stub_request(:get, "https://api.pagerduty.com/users")
        .with(
          headers: {
            "Authorization" => "Token token=#{token}",
            "User-Agent" => "Mozilla/5.0"
          }
        )
        .to_return(
          status: 200,
          body: File.read("spec/fixtures/get_users.json"),
          headers: { "Content-Type" => "application/json" }
        )
    end

    it "returns an array of User objects" do
      users = client.get_users
      expect(users).to be_an(Array)
      expect(users.first).to be_a(User)
      expect(users.first.name).to eq("Account Owner")
    end
  end
end
