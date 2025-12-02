require "spec_helper"

RSpec.describe PagerdutyCli::CLI do
  let(:cli) { described_class.new }

  describe "#hello" do
    it "sends the correct message and color to the helper" do
      expect(cli).to receive(:print_to_user).with("Hello world", :green)
      cli.hello("world")
    end
  end

  describe "default task" do
    it "shows the help message" do
      expect do
        described_class.start([])
      end.to output(/Commands:/).to_stdout
    end
  end
end
