require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".srt" do
  describe "Out" do
       
    before(:each) do
      yml = File.open(File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sincity.yml')) 
      @sub = Subtitle.new(yml,'yml')    
    end  
  
    it "should dump the object as a SRT" do
      @sub.to_srt.should eql("0\n00:05:26.500 --> 00:05:28.500worth killing for...1\n00:06:00.400 --> 00:06:03.400worth dying for...2\n00:07:00.300 --> 00:07:03.300worth going to the hell for...")
    end
  end  
end