require "spec_helper"
require "pagerduty_cli/user"

RSpec.describe User do
  it "initializes with data" do
    data = { "name" => "Ramza Beoulve", "email" => "gallant_knight@ivalice.com" }
    user = User.new(data)
    expect(user.name).to eq("Ramza Beoulve")
    expect(user.email).to eq("gallant_knight@ivalice.com")
  end
end
