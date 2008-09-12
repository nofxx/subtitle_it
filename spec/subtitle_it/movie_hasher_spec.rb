require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MovieHasher do
  
  it "should generate a beatiful hash for us" do
    MovieHasher::CHUNK_SIZE.should eql(65536)

    File.should_receive(:size).with('onefile').and_return(1020)
    File.should_receive(:open).with("onefile", "rb")
    
    MovieHasher.compute_haxx('onefile').should eql("00000000000003fc")    
  end  
end