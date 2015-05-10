require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subtime do
  before(:each) do
    @subtime =  Subtime.new('01:02:03.400')
  end

  it 'should convert the hour, minutes and seconds' do
    expect(@subtime.hrs).to eql(1)
    expect(@subtime.min).to eql(2)
    expect(@subtime.sec).to eql(3)
    expect(@subtime.ms).to eql(400)
  end

  it 'should reduce the deciseconds' do
    expect(800.reduce).to eql(8)
  end

  it 'should print nicely as string' do
    expect(@subtime.to_s).to eql('01:02:03.400')
  end

  it 'should become a integer' do
    expect(@subtime.to_i).to eql(3_723_400)
  end
end

describe 'and the other way around' do
  it 'should print nicely' do
    @subtime = Subtime.new(3_723_400)
    expect(@subtime.to_s).to eql('01:02:03.400')
  end
end

describe Subtime, 'Stress Test (heh)' do
  it 'should convert a big time' do
    @subtime =  Subtime.new('11:22:33.742')
    expect(@subtime.hrs).to eql(11)
    expect(@subtime.min).to eql(22)
    expect(@subtime.sec).to eql(33)
    expect(@subtime.ms).to eql(742)
  end

  it 'should print nicely' do
    @subtime =  Subtime.new('11:22:33.7')
    expect(@subtime.to_s).to eql('11:22:33.700')
  end

  describe '.other formats' do
    it 'should parse min:sec.ms' do
      @subtime = Subtime.new('01:03.4')
    end

    it 'should parse min:sec,ms' do
      @subtime = Subtime.new('01:03,3')
    end

    it 'should single as seconds hour should be nil' do
      @subtime = Subtime.new('3')
      expect(@subtime.hrs).to eql(0)
    end

    it 'should parse min:sec' do
      @subtime = Subtime.new('01:03')
      expect(@subtime.min).to eql(1)
    end

    after(:each) do
      expect(@subtime.sec).to eql(3)
    end
  end
end
