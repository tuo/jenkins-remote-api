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
    }.to raise_exception("Error in grabbing xml of http://deadlock.netbeans.org/hudson/api/xml due to network problem.")    
  end

  it "should raise error when xml is illegal" do 
    mechanize = mock("Mechanize")
    Mechanize.stub(:new).and_return(mechanize)
    result = mock("some xml ouput")
  xml = <<EOF
<html>helloworld
some test
EOF
    result.stub(:body).and_return(xml)
    mechanize.should_receive(:get).with(ci_url + "api/xml").and_yield(result)
    expect {
      jenkins.list_all_job_names
    }.to raise_exception(
"Error parsing xml from http://deadlock.netbeans.org/hudson/api/xml due to format.")    
  end
    
  it "should return empty array when page doesn't have job info" do 
    mechanize = mock("Mechanize")
    Mechanize.stub(:new).and_return(mechanize)
    result = mock("some xml ouput")
    xml = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<hudson>
  <assignedLabel/>
  <mode>NORMAL</mode>
</hudson>
EOF
    result.stub(:body).and_return(xml)
    mechanize.should_receive(:get).with(ci_url + "api/xml").and_yield(result)
    jenkins.list_all_job_names.should == []
  end  
  
  describe "for legal xml source" do 
    
    before(:each) do
      mechanize = mock("Mechanize")
      Mechanize.stub(:new).and_return(mechanize)
      result = mock("some xml ouput")
      result.stub(:body).and_return(legal_xml_source)
      mechanize.should_receive(:get).with(ci_url + "api/xml").and_yield(result)
    end
    
    context "#job_named" do
      it "should get corresponding job for name" do
        Ci::Job.should_receive(:new).with("http://deadlock.netbeans.org/hudson/job/analytics-server/")
        jenkins.job_named("analytics-server")
      end
    
      it "should throw error info when job with name doesn't exist" do
        expect {
          jenkins.job_named("some job")
        }.to raise_exception("The job with name 'some job' doesn't exist in job list of #{ci_url}api/xml.Using jenkins.list_all_job_names to see list.")          
      end  
    end

    context "#list_all_jobs_info" do
      it "should get list_all_jobs_info" do
        jenkins.jobs_description.should == [
              {
                :name => "analytics-server", 
                :status => "disabled",
                :url => "http://deadlock.netbeans.org/hudson/job/analytics-server/",
              }, 
              {
                :name => "apitest", 
                :status => "success",
                :url => "http://deadlock.netbeans.org/hudson/job/apitest/",
              }]
      end    
    end 
    
    it "should get current status of job on ci" do
      jenkins.current_status_on_job("apitest").should == "success"
    end

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
