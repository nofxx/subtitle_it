require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".srt" do
  describe "Out" do
       
    before(:each) do
      yml = File.open(File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sincity.yml')) 
      @sub = Subtitle.new(yml,'yml')    
    end  
  
    it "should dump the object as a SRT" do
      @sub.to_srt.should eql("0\n02:52:262,000 --> 02:52:282,000worth killing for...1\n02:62:02,000 --> 02:62:32,000worth dying for...2\n02:72:02,000 --> 02:72:32,000worth going to the hell for...")
    end
  end  
end