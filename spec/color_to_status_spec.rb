require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ci::ColorToStatus do
  
  it "should get disabled for color grey" do
    Ci::ColorToStatus.get_status_to("grey").should == "disabled"
  end

  it "should get disabled for color disabled" do
    Ci::ColorToStatus.get_status_to("disabled").should == "disabled"
  end

  it "should get successs for color blue" do
    Ci::ColorToStatus.get_status_to("blue").should == "success"
  end

  it "should get failure for color red" do
    Ci::ColorToStatus.get_status_to("red").should == "failure"
  end
  it "should get aborted for color aborted" do
    Ci::ColorToStatus.get_status_to("aborted").should == "aborted"
  end

  it "should get disabled for color grey" do
    Ci::ColorToStatus.get_status_to("yellow").should == "unstable"
  end
  
  context "for animation to return building" do
    it "should get building for color grey_anime" do
      Ci::ColorToStatus.get_status_to("grey_anime").should == "building"
    end

    it "should get building for color grey_anime" do
      Ci::ColorToStatus.get_status_to("blue_anime").should == "building"
    end

    it "should get building for color grey_anime" do
      Ci::ColorToStatus.get_status_to("red_anime").should == "building"
    end    
  end
  
  it "should throw error info when color has no match to status" do
    expect {
      Ci::ColorToStatus.get_status_to("unkown")
    }.to raise_exception("This color 'unkown' and its corresponding status hasn't been added to library, pls contact author.")          
  end  
  

end
