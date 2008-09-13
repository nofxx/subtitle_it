require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".yml" do
  describe "Out" do
    include SubFixtures
    
    before(:each) do    
      @sub = Subtitle.new(nil, yml_fixture,'yml')    
    end  
  
    it "should have author" do
      @sub.to_yml.should match(/author: warlley, nofxx/)
    end
    
    it "should have version" do
      @sub.to_yml.should match(/version: 1.1/)
    end
    
  end  
end