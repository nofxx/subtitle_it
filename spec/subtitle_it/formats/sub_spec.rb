require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".sub" do
  describe "Out" do

    before(:each) do
      yml = File.open(File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sincity.yml')) 
      @sub = Subtitle.new(yml,'yml')    
    end  

    it "should dump the object as a SUB" do
      @sub.to_sub.should eql("{26}{28}worth killing for...{0}{3}worth dying for...{0}{3}worth going to the hell for...")
    end
  end  
end