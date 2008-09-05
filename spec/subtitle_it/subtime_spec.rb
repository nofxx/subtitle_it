require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subtime do
  before(:each) do
    @subtime =  Subtime.new('01:02:03')
  end
  
  it "should convert in seconds" do
    @subtime.hour.should eql(1)
  end
  
  it "should convert in minutes" do
    @subtime.min.should eql(2)
  end
  
  it "should convert in hours" do
    @subtime.sec.should eql(3)
  end
end

describe Subtime,"2" do
  before(:each) do
    @subtime =  Subtime.new('11:22:33')
  end
  
  it "should convert in hour" do
    @subtime.hour.should eql(11)
  end
  
  it "should convert in minutes" do
    @subtime.min.should eql(22)
  end
  
  it "should convert in seconds" do
    @subtime.sec.should eql(33)
  end
end

describe Subtime, ".other formats" do
  
  it "should parse comma" do
    @subtime = Subtime.new('01,01,03')
  end

  it "should parse dot" do
    @subtime = Subtime.new('01.01,03')
  end
  
  it "should parse dot" do
    @subtime = Subtime.new('3')
  end
  
  it "should parse dot" do
    @subtime = Subtime.new('01:03')
    @subtime.min.should eql(1)
  end
  
  after(:each) do
    @subtime.sec.should eql(3)
  end
  
end