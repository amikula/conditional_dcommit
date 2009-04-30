require File.join(File.dirname(__FILE__), '..', 'spec_helper')

require 'conditional_dcommit/package'

describe ConditionalDcommit::Package do
  def subject
    ConditionalDcommit::Package
  end

  describe :data_path do
    it "should point to a directory containing data I care about" do
      File.file?(File.join(subject.data_path, 'stop_sign.jpg')).should be_true
    end
  end

  describe :data_file do
    it "should return a path starting with data_path and ending with the data file specified" do
      subject.data_file('foo').should == File.join(subject.data_path, 'foo')
    end
  end
end
