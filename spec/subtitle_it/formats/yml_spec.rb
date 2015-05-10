require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, '.yml' do
  describe 'Out' do
    include SubFixtures

    before(:each) do
      @sub = Subtitle.new(dump: yml_fixture, format: 'yml')
    end

    it 'should have author' do
      expect(@sub.to_yml).to match(/author: warlley, nofxx/)
    end

    it 'should have version' do
      expect(@sub.to_yml).to match(/version: 1.1/)
    end
  end
end
