require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".srt" do
  include SubFixtures
  describe "In" do
    
    before(:each) do
      @srt = Subtitle.new(srt_fixture,'srt') 
    end  

    it "should parse the sub to an array" do
      @srt.lines.should be_instance_of(Array)
    end
    
    it "should have N lines" do
      @srt.should have(543).lines      
    end
    
    it "should parse time of" do
      @srt.lines[0].time_on.to_s.should eql("00:01:43.680")
    end
    
    it "should parse time of" do
      @srt.lines[0].time_off.to_s.should eql("00:01:45.557")
    end
    
    it "should parse text" do
      @srt.lines[0].text.should eql("My dear children,")
    end
  end
    
  describe "Out!" do
       
    before(:each) do
      @sub = Subtitle.new(yml_fixture,'yml')    
    end  
  
    it "should dump the object as a SRT" do
      @sub.to_srt.should eql("0\n00:05:26.500 --> 00:05:28.500\nworth killing for...\n1\n00:06:00.400 --> 00:06:03.400\nworth dying for...\n2\n00:07:00.300 --> 00:07:03.300\nworth going to the hell for...\n3\n00:07:00.300 --> 00:07:03.300\nworth going a \n line...")
    end
  end
end