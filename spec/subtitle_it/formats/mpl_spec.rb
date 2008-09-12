require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".mpl" do
  include SubFixtures
  describe "In" do
    
    before(:each) do
      @mpl = Subtitle.new(mpl_fixture,'mpl') 
    end  

    it "should parse the sub to an array" do
      @mpl.lines.should be_instance_of(Array)
    end
    
    it "should have N lines" do
      @mpl.should have(12).lines      
    end
    
    it "should parse time of" do
      @mpl.lines[0].time_on.to_s.should eql("00:17:05.000")
    end
    
    it "should parse time of" do
      @mpl.lines[0].time_off.to_s.should eql("00:18:35.000")
    end
    
    it "should parse text" do
      @mpl.lines[0].text.should eql("You always say that.|The same thing every time.")
    end
  end
    
  describe "Out!" do
       
    before(:each) do
      @sub = Subtitle.new(yml_fixture,'yml')    
    end  
  
    it "should dump the object as a SRT" do
      @sub.to_mpl.should eql("[3265][3285]worth killing for...
[3604][3634]worth dying for...
[4203][4233]worth going to the hell for...
[4203][4233]worth going a | line...")
    end
  end
end