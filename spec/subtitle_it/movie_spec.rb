require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Movie do
  before(:each) do
    @movie = Movie.new('pulpfiction')
  end
  
  it "should initialize nicely" do
    @movie.info.should be_instance_of(Hash)
    @movie.filename.should eql("pulpfiction")
  end
  
  it "should call for a hash" do
    File.should_receive(:open).with("pulpfiction", "rb")
    File.should_receive(:size).with('pulpfiction').and_return(13141)
    #TODO.. how to mock this?
    #MovieHasher.should_receive(:compute_hash)
    @movie.haxx.should eql('0000000000003355')
  end
  
  it "should call for size" do
    File.should_receive(:size).with('pulpfiction')
    @movie.size
  end  
end
