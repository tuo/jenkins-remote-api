require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ci::Jenkins do
  
  let(:ci_url) { "http://deadlock.netbeans.org/hudson/" }
  let(:jenkins) { Ci::Jenkins.new(ci_url) }
  
  it "should set initialize jenkins instance with ci address" do
    jenkins.ci_address.should == ci_url
  end
  
  it "should get all job's names for specific ci" do 
    mechanize = mock("Mechanize")
    Mechanize.stub(:new).and_return(mechanize)
    xml = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<hudson>
  <assignedLabel/>
  <mode>NORMAL</mode>
  <nodeDescription>the master Hudson node</nodeDescription>
  <job>
    <name>analytics-server</name>
    <url>
      http://deadlock.netbeans.org/hudson/job/analytics-server/
    </url>
    <color>disabled</color>
  </job>
  <job>
    <name>apitest</name>
    <url>http://deadlock.netbeans.org/hudson/job/apitest/</url>
    <color>blue</color>
  </job>
</hudson>
EOF
    result = mock("some xml ouput")
    result.stub(:body).and_return(xml)
    mechanize.should_receive(:get).with(ci_url + "api/xml").and_yield(result)
    jenkins.list_all_job_names.should == ["analytics-server", "apitest"]
  end
end
