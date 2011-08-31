require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ci::Jenkins do
  
  let(:ci_url) { "http://deadlock.netbeans.org/hudson/" }
  let(:jenkins) { Ci::Jenkins.new(ci_url) }
  
  it "should set initialize jenkins instance with ci address" do
    jenkins.ci_address.should == ci_url
  end

  it "should set initialize jenkins instance with ci address" do
    jenkins_without_end_slash = Ci::Jenkins.new("helloworld.com")
    jenkins_without_end_slash.ci_address.should == "helloworld.com/"
  end

  
  it "should get all job's names for specific ci" do 
    mechanize = mock("Mechanize")
    Mechanize.stub(:new).and_return(mechanize)
    result = mock("some xml ouput")
    result.stub(:body).and_return(legal_xml_source)
    mechanize.should_receive(:get).with(ci_url + "api/xml").and_yield(result)
    jenkins.list_all_job_names.should == ["analytics-server", "apitest"]
  end
  
  it "should prompt network problem info when mechanize can't get right response" do 
    mechanize = mock("Mechanize")
    Mechanize.stub(:new).and_return(mechanize)
    error_page = mock("some error page")
    error_page.stub(:code).and_return("403 error,lost connection")
    mechanize.stub(:get).and_raise(Mechanize::ResponseCodeError.new(error_page))
    expect {
      jenkins.list_all_job_names
    }.to raise_exception("Error in grabbing xml of #{ci_url}/api/xml due to network problem.")

    
    # mechanize = mock("Mechanize")
    # Mechanize.stub(:new).and_return(mechanize)
    # mechanize.should_receive(:get).with(ci_url + "api/xml").and_raise(Mechanize::ResponseCodeError)
    # puts jenkins.list_all_job_names
    
  end
  
  
  def legal_xml_source
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
    xml
  end
end
