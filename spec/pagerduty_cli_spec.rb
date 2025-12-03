require "spec_helper"

RSpec.describe PagerdutyCli::CLI do
  let(:cli) { described_class.new }

  context "with PD_API_TOKEN set" do
    before do
      allow(ENV).to receive(:[]).and_call_original # thor requires this to be set
      allow(ENV).to receive(:[]).with("PD_API_TOKEN").and_return("test-token")
    end

    describe "#user(id)" do
      let(:users_fixture) { JSON.parse(File.read("spec/fixtures/get_users.json"))["users"] }
      let(:user_objects) { users_fixture.map { |u| User.new(u) } }

      before do
        client = instance_double(PagerdutyCli::Client, get_users: user_objects)
        allow(PagerdutyCli::Client).to receive(:new).and_return(client)
        allow(client).to receive(:get_user).with('PRJ4208').and_return(user_objects.first)
        allow(client).to receive(:get_user).with('DEADBEEF').and_return(nil)
      end

      around do |example|
        original_stdout = $stdout
        $stdout = File.open(File::NULL, "w")
        example.run
        $stdout = original_stdout
      end

      it "Displays data on specific user" do
        expect(cli).to receive(:print_to_user).with("initializing...", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  - Verify api token is set.", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("Setup successful.", :green).ordered

        expect(cli).to receive(:print_to_user).with("Found user:", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  Name - Account Owner", :cyan).ordered
        expect(cli).to receive(:print_to_user).with("  Email - bwillemsen@pagerduty.com", :cyan).ordered
        expect(cli).to receive(:print_to_user).with("  Time Zone - America/Los_Angeles", :cyan).ordered
        expect(cli).to receive(:print_to_user).with("  Color - dark-slate-blue", :cyan).ordered
        # Allow any other calls, since we've established at least two are printing
        allow(cli).to receive(:print_to_user).with(any_args)

        cli.user("PRJ4208")
      end

      it "Returns a message if the user is not found" do
        expect(cli).to receive(:print_to_user).with("initializing...", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  - Verify api token is set.", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("Setup successful.", :green).ordered

        expect(cli).to receive(:print_to_user).with("User Not Found with ID: DEADBEEF", :red).ordered

        expect { cli.user("DEADBEEF") }.to raise_error(SystemExit) do |e|
          expect(e.status).to eq(1)
        end
      end
    end

    describe "#users" do
      let(:users_fixture) { JSON.parse(File.read("spec/fixtures/get_users.json"))["users"] }
      let(:user_objects) { users_fixture.map { |u| User.new(u) } }

      before do
        client = instance_double(PagerdutyCli::Client, get_users: user_objects)
        allow(PagerdutyCli::Client).to receive(:new).and_return(client)
      end

      around do |example|
        original_stdout = $stdout
        $stdout = File.open(File::NULL, "w")
        example.run
        $stdout = original_stdout
      end

      it "lists the users" do
        expect(cli).to receive(:print_to_user).with("initializing...", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  - Verify api token is set.", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("Setup successful.", :green).ordered
        expect(cli).to receive(:print_to_user).with("Found users:", :yellow).ordered
        expect(cli).to receive(:print_to_user).with("  PRJ4208 - Account Owner", :cyan).ordered
        expect(cli).to receive(:print_to_user).with("  PL0TA9M - Alex Mitchell", :cyan).ordered
        # Allow any other calls, since we've established at least two are printing
        allow(cli).to receive(:print_to_user).with(any_args)

        cli.users
      end
    end
  end

  context "with PD_API_TOKEN NOT set" do
    before do
      allow(ENV).to receive(:[]).and_call_original # thor requires this to be set
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

        expect { cli.users }.to raise_error(SystemExit) do |e|
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
