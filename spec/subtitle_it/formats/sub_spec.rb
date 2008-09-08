require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".sub" do
  describe "Parse" do

    before(:each) do
      sub = File.open(File.expand_path(File.dirname(__FILE__) + '/../../fixtures/pulpfiction.sub')) 
      @sub = Subtitle.new(sub,'sub') 
    end  

    it "should parse the sub to an array" do
      @sub.lines.should be_instance_of(Array)#eql("{26}{28}worth killing for...{0}{3}worth dying for...{0}{3}worth going to the hell for...")
    end
    
    it "should have N lines" do
      @sub.should have(2025).lines      
    end
    
    it "should have a nic text on" do
      @sub.lines[0].text_on.to_s.should eql('00:01:42.500')
    end
    
    it "should have a nice text out" do
      @sub.lines[0].text_off.to_s.should eql('00:01:51.500')
    end
    
    it "should parse the sentece correctly" do
      @sub.lines[0].text.should eql("You always say that.|The same thing every time.\n")
    end    
  end
  
  
  describe "Out" do

    before(:each) do
      yml = File.open(File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sincity.yml')) 
      @sub = Subtitle.new(yml,'yml')    
    end  

    it "should dump the object as a SUB" do
      @sub.to_sub.should eql("{136}{137}worth killing for...{150}{151}worth dying for...{175}{176}worth going to the hell for...")
    end
  end  
end