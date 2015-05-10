require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, '.sub' do
  include SubFixtures
  describe 'Parse' do
    before(:each) do
      @sub = Subtitle.new(dump: sub_fixture, format: 'sub')
    end

    it 'should parse the sub to an array' do
      expect(@sub.lines).to be_instance_of(Array)
    end

    it 'should have N lines' do
      expect(@sub.lines.length).to eq(2025)
    end

    it 'should have a nic text on' do
      expect(@sub.lines[110].time_on.to_s).to eql('00:10:44.936')
    end

    it 'should have a nice text out' do
      expect(@sub.lines[110].time_off.to_s).to eql('00:10:49.941')
    end

    it 'should parse the sentece correctly' do
      expect(@sub.lines[0].text).to eql('You always say that.|The same thing every time.')
    end

    it 'should parse the sentece correctly' do
      expect(@sub.lines[2020].text).to eql("I'm tryin' real hard...")
    end
  end

  describe 'Out' do
    before(:each) do
      @sub = Subtitle.new(dump: yml_fixture, format: 'yml')
    end

    it 'should dump the object as a SUB' do
      expect(@sub.to_sub).to eql("{7816}{7864}worth killing for...
{8631}{8703}worth dying for...
{10069}{10141}worth going to the hell for...
{10069}{10141}worth going a | line...\n")
    end
  end
end
