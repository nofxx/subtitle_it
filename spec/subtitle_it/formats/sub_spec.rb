require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".sub" do
  include SubFixtures
  describe "Parse" do
  
    before(:each) do
      @sub = Subtitle.new(sub_fixture,'sub') 
    end  

    it "should parse the sub to an array" do
      @sub.lines.should be_instance_of(Array)
    end
    
    it "should have N lines" do
      @sub.should have(2025).lines      
    end
    
    it "should have a nic text on" do
      @sub.lines[0].text_on.to_s.should eql('00:00:01.025')
    end
    
    it "should have a nice text out" do
      @sub.lines[0].text_off.to_s.should eql('00:00:01.115')
    end
    
    it "should parse the sentece correctly" do
      @sub.lines[0].text.should eql("You always say that.|The same thing every time.")
    end    
    
    it "should parse the sentece correctly" do
      @sub.lines[2020].text.should eql("I'm tryin' real hard...")
    end
  end
  
  describe "Out" do

    before(:each) do
      @sub = Subtitle.new(yml_fixture,'yml')    
    end  

    it "should dump the object as a SUB" do
      @sub.to_sub.should eql("{136}{137}worth killing for...{150}{151}worth dying for...{175}{176}worth going to the hell for...")
    end
  end  
end