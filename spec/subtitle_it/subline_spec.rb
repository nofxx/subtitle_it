require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subline do
  before(:each) do
    @sub =  Subline.new('02:20:02', '4', 'Astalavista, baby...')
  end

  it "should initialize #{name}" do
    expect(@sub.text).to eql('Astalavista, baby...')
  end

  it 'should have a nice date on' do
    expect(@sub.time_on.sec).to eql(2)
    expect(@sub.time_on.min).to eql(20)
    expect(@sub.time_on.sec).to eql(2)
  end

  it 'should have the seconds added from the first time' do
    expect(@sub.time_off.sec).to eql(6)
  end
end

describe Subline, '.failures' do
  it 'should correct a timeline beforehe on time' do
    expect do
      Subline.new('00:03:01', '00:02:03', 'Astalavista, baby...')
    end.not_to raise_error
  end
end
