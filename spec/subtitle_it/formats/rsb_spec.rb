require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".rsb" do
  include SubFixtures
  describe "In" do

    before(:each) do
      @rsb = Subtitle.new({:dump => rsb_fixture, :format => 'rsb'})
    end

    it "should parse the sub to an array" do
      expect(@rsb.lines).to be_instance_of(Array)
    end

    it "should have N lines" do
      expect(@rsb.lines.length).to eq(3)
    end

    it "should parse time of" do
      expect(@rsb.lines[0].time_on.to_s).to eql("00:05:26.500")
    end

    it "should parse time of" do
      expect(@rsb.lines[0].time_off.to_s).to eql("00:05:28.500")
    end

    it "should parse text" do
      expect(@rsb.lines[0].text).to eql("worth killing for...")
    end
  end

  describe "Out" do
    include SubFixtures
    before(:each) do
      @sub = Subtitle.new({:dump => yml_fixture, :format => 'yml'})
    end

    it "should dump the object to rsb" do
      expect(@sub.to_rsb).to eql("- title: sincity\n- authors: \n- version: 1.1\n00:05:26.500 => 00:05:28.500 == worth killing for...\n00:06:00.400 => 00:06:03.400 == worth dying for...\n00:07:00.300 => 00:07:03.300 == worth going to the hell for...\n00:07:00.300 => 00:07:03.300 == worth going a | line...\n")
    end
  end
end
