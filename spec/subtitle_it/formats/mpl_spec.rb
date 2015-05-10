require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, '.mpl' do
  include SubFixtures
  describe 'In' do
    before(:each) do
      @mpl = Subtitle.new(dump: mpl_fixture, format: 'mpl')
    end

    it 'should parse the sub to an array' do
      expect(@mpl.lines).to be_instance_of(Array)
    end

    it 'should have N lines' do
      expect(@mpl.lines.length).to eq(12)
    end

    it 'should parse time of' do
      expect(@mpl.lines[0].time_on.to_s).to eql('00:17:05.000')
    end

    it 'should parse time of' do
      expect(@mpl.lines[0].time_off.to_s).to eql('00:18:35.000')
    end

    it 'should parse text' do
      expect(@mpl.lines[0].text).to eql('You always say that.|The same thing every time.')
    end
  end

  describe 'Out!' do
    before(:each) do
      @sub = Subtitle.new(dump: yml_fixture, format: 'yml')
    end

    it 'should dump the object as a SRT' do
      expect(@sub.to_mpl).to eql("[3265][3285]worth killing for...
[3604][3634]worth dying for...
[4203][4233]worth going to the hell for...
[4203][4233]worth going a | line...\n")
    end
  end
end
