require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Jenkins do
  it "should works as first spec" do
    Jenkins.first_spec_status.should == "hello world"
  end
end