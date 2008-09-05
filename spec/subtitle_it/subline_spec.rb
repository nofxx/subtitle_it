require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subline do
  before(:each) do
    @sub =  Subline.new('03:23:41','3',"Astalavista, baby...")
  end
  
  it "should initialize #{name}" do
    @sub.text.should eql("Astalavista, baby...") 
  end
  
  it "should have a nice date on" do
    @sub.text_on.sec.should eql(41)
    @sub.text_on.min.should eql(23)    
  end
  
  it "should have minutes" do
    @sub.text_on.min.should eql(23)
  end
end

describe Subline, ".failures" do
  
  it "should correct a timeline beforehe on time" do
    lambda do
      Subline.new('00:03:01','00:02:03',"Astalavista, baby...") 
    end.should_not raise_error 
  end
  
  
end