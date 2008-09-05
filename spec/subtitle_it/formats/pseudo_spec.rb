require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".yml" do
  describe "Out" do
       
    # before(:each) do
    #   yml = File.open(File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sincity.yml')) 
    #   @sub = Subtitle.new(yml,'yml')    
    # end  
    #   
    # it "should dump the object as a YML" do
    #   @sub.to_yml.should eql("--- !ruby/object:SubtitleIt::Subtitle \nauthor: warlley, nofxx\nformat: yml\nframerate: 23.976\nlines: \n- !ruby/object:SubtitleIt::Subline \n  text: \n  text_off: !ruby/object:SubtitleIt::Subtime \n    sec_raw: 328\n  text_on: !ruby/object:SubtitleIt::Subtime \n    sec_raw: 326\n- !ruby/object:SubtitleIt::Subline \n  text: \n  text_off: !ruby/object:SubtitleIt::Subtime \n    sec_raw: 363\n  text_on: !ruby/object:SubtitleIt::Subtime \n    sec_raw: 360\n- !ruby/object:SubtitleIt::Subline \n  text: \n  text_off: !ruby/object:SubtitleIt::Subtime \n    sec_raw: 423\n  text_on: !ruby/object:SubtitleIt::Subtime \n    sec_raw: 420\nraw: !ruby/object:File {}\n\ntitle: sincity\nversion: 1.1\nyaml: \n  lines: \n  - - \"00:05:26\"\n    - \"00:05:28\"\n    - worth killing for...\n  - - \"00:06:00\"\n    - \"00:06:03\"\n    - worth dying for...\n  - - \"00:07:00\"\n    - \"00:07:03\"\n    - worth going to the hell for...\n")    
    # end
  end  
end