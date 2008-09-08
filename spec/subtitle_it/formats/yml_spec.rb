require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".yml" do
  describe "Out" do
    include SubFixtures
    
    before(:each) do    
      @sub = Subtitle.new(yml_fixture,'yml')    
    end  
  
    it "should dump the object as a YML" do
      @sub.to_yml.should eql("--- !ruby/object:SubtitleIt::Subtitle \nauthor: warlley, nofxx\nformat: yml\nfps: 23.976\nlines: \n- !ruby/object:SubtitleIt::Subline \n  text: worth killing for...\n  text_off: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 5\n    ms: 500\n    sec: 28\n  text_on: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 5\n    ms: 500\n    sec: 26\n- !ruby/object:SubtitleIt::Subline \n  text: worth dying for...\n  text_off: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 6\n    ms: 400\n    sec: 3\n  text_on: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 6\n    ms: 400\n    sec: 0\n- !ruby/object:SubtitleIt::Subline \n  text: worth going to the hell for...\n  text_off: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 7\n    ms: 300\n    sec: 3\n  text_on: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 7\n    ms: 300\n    sec: 0\n- !ruby/object:SubtitleIt::Subline \n  text: worth going a | line...\n  text_off: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 7\n    ms: 300\n    sec: 3\n  text_on: !ruby/object:SubtitleIt::Subtime \n    hrs: 0\n    min: 7\n    ms: 300\n    sec: 0\nraw: !ruby/object:File {}\n\ntitle: sincity\nversion: 1.1\nyaml: \n  lines: \n  - - \"00:05:26.5\"\n    - \"00:05:28.5\"\n    - worth killing for...\n  - - \"00:06:00.4\"\n    - \"00:06:03.4\"\n    - worth dying for...\n  - - \"00:07:00.3\"\n    - \"00:07:03.3\"\n    - worth going to the hell for...\n  - - \"00:07:00.3\"\n    - \"00:07:03.3\"\n    - worth going a | line...\n")
    end
  end  
end