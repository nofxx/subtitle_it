require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subtime do
  before(:each) do
    @subtime =  Subtime.new('01:02:03.400')
  end
  
  it "should convert the hour" do
    @subtime.hrs.should eql(1)
  end
  
  it "should convert in minutes" do
    @subtime.min.should eql(2)
  end
  
  it "should convert in hours" do
    @subtime.sec.should eql(3)
  end
  
  it "should reduce the deciseconds" do
    800.reduce.should eql(8)
  end 
  
  it "should have ms" do
    @subtime.ms.should eql(400)        
  end
  
  it "should print nicely" do
    @subtime.to_s.should eql("01:02:03.400")
  end
  
  it "should print nicely" do
    @subtime.to_i.should eql(3723400)
  end
end

describe Subtime,"22" do
  it "should convert a big time" do
    @subtime =  Subtime.new('11:22:33.742')
    @subtime.hrs.should eql(11)    
    @subtime.min.should eql(22)    
    @subtime.sec.should eql(33)    
    @subtime.ms.should eql(742)        
  end
  
  it "should print nicely" do
    @subtime =  Subtime.new('11:22:33.7')    
    @subtime.to_s.should eql("11:22:33.700")    
  end
end

describe Subtime, ".other formats" do
  
  it "should parse comma" do
    @subtime = Subtime.new('01:03.4')
  end

  it "should parse dot" do
    @subtime = Subtime.new('01:03,3')
  end
  
  it "should parse dot" do
    @subtime = Subtime.new('3')
    @subtime.hrs.should eql(0)
  end
  
  it "should parse dot" do
    @subtime = Subtime.new('01:03')
    @subtime.min.should eql(1)
  end
  
  after(:each) do
    @subtime.sec.should eql(3)
  end
  
end