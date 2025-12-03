require "spec_helper"

RSpec.describe PagerdutyCli::CLI do
  let(:cli) { described_class.new }

  context "with PD_API_TOKEN set" do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("PD_API_TOKEN").and_return("test-token")
    end

    describe "#hello" do
      around do |example|
        original_stdout = $stdout
        $stdout = File.open(File::NULL, "w")
        example.run
        $stdout = original_stdout
      end

      it "initializes and then runs the command" do
        expect(cli).to receive(:print_to_user).with("initializing...", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  - Verify api token is set.", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("Setup successful.", :green).ordered
        expect(cli).to receive(:print_to_user).with("Hello world", :green).ordered
        cli.hello("world")
      end
    end

    describe "default task" do
      it "shows the help message" do
        expect do
          cli.help
        end.to output(/Commands:/).to_stdout
      end
    end
  end

  context "with PD_API_TOKEN NOT set" do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("PD_API_TOKEN").and_return(nil)
    end

    describe "running a command" do
      around do |example|
        original_stdout = $stdout
        $stdout = File.open(File::NULL, "w")
        example.run
        $stdout = original_stdout
      end

      it "exits with an error message" do
        expect(cli).to receive(:print_to_user).with("initializing...", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  - Verify api token is set.", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("PD_API_TOKEN environment variable not set.", :red).ordered

        expect do
          cli.hello("world")
        end.to raise_error(SystemExit) do |e|
          expect(e.status).to eq(1)
        end
      end
    end

    describe "running help command" do
      it "does not exit and shows help" do
        expect do
          cli.help
        end.to output(/Commands:/).to_stdout
      end
    end
  end
end
