require File.join(File.dirname(__FILE__), '..', 'spec_helper')

require 'conditional_dcommit/command'

describe ConditionalDcommit::Command do
  def subject
    @subject ||= ConditionalDcommit::Command.new
  end

  describe :test_command do
    it "returns the environment variable 'TEST_COMMAND'" do
      ENV.should_receive(:[]).with('TEST_COMMAND').and_return("test command")

      subject.test_command.should == 'test command'
    end

    it "defaults to 'script/cruise'" do
      ENV.should_receive(:[]).and_return(nil)

      subject.test_command.should == 'script/cruise'
    end

    it "caches the test_command value" do
      ENV.should_receive(:[]).exactly(1).times.with('TEST_COMMAND').and_return(nil)

      subject.test_command.should == 'script/cruise'
      subject.test_command.should == 'script/cruise'
    end
  end

  describe :report_fail do
    before(:each) do
      subject.stub!(:puts)
      subject.stub!(:growl)
    end

    it 'outputs the failure message to the console' do
      subject.should_receive(:puts).with(:message)

      subject.report_fail(:message)
    end

    it "sets status code to 255" do
      subject.report_fail(:anything)

      subject.status_code.should == 255
    end

    it "growls the message" do
      subject.should_receive(:growl).with('FAIL', :message, anything)

      subject.report_fail(:message)
    end

    it "growls with the failure image" do
      ConditionalDcommit::Package.should_receive(:data_file).with('stop_sign.jpg').and_return(:stop_sign_file)
      subject.should_receive(:growl).with('FAIL', anything, :stop_sign_file)

      subject.report_fail(:message)
    end
  end
end
