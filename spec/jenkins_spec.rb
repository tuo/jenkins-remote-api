require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ci::Jenkins do
  
  it "should set Jenkins ci address" do
    Ci::Jenkins.set_ci_addr("http://some_ci_address:8080/")
    Ci::Jenkins.ci_addr.should == "http://some_ci_address:8080/"
  end

  it "should set Ci::Jenkins ci address end with slash" do
    Ci::Jenkins.set_ci_addr("http://some_ci_address:8080")
    Ci::Jenkins.ci_addr.should == "http://some_ci_address:8080/"
  end
  
  it "should get all job's names for specific ci" do 
    ci_addr = "http://deadlock.netbeans.org/hudson/"
    Ci::Jenkins.set_ci_addr(ci_addr)
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
    mechanize.should_receive(:get).with(ci_addr + "api/xml").and_yield(result)
    Ci::Jenkins.list_all_job_names.should == ["analytics-server", "apitest"]
  end
end
