require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subline do
#  before(:each) do
    @sublines = {
     :srt =>  Subline.new('00:00:03','00:03:03',"Astalavista, baby..."),
     :yml =>    Subline.new('00:00:03','00:03:03',"Astalavista, baby..."),
     :pseudo => Subline.new('00:03','03:03',"Astalavista, baby..."),
     :pseudo_nice => Subline.new('00:03','3:03',"Astalavista, baby..."),     
     :pseudo_cool => Subline.new('00:03','3',"Astalavista, baby...")
      #]                  
    }
 # end
  
  @sublines.each do |name,sub|
  
  it "should initialize #{name}" do
    sub.text.should eql("Astalavista, baby...") 
  end
  
  it "should have a nice date on and off" do
   sub.text_on.should be_kind_of(Subtime) 
    sub.text_off.should be_kind_of(Subtime) 
  end
  
  it "should have minutes" do
    sub.text_on.sec.should eql(3)
  end
  
end
end

describe Subline, ".failures" do
  
  it "should correct a timeline before on time" do
    lambda do
      Subline.new('00:03:01','00:02:03',"Astalavista, baby...") 
    end.should_not raise_error 
  end
  
  
end