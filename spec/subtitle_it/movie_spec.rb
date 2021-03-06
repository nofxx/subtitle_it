require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Movie do
  before(:each) do
    @movie = Movie.new('pulpfiction')
  end

  it 'should initialize nicely' do
    expect(@movie.info).to be_instance_of(Hash)
    expect(@movie.filename).to eql('pulpfiction')
  end

  it 'should call for a hash' do
    expect(File).to receive(:open).with('pulpfiction', 'rb')
    expect(File).to receive(:size).with('pulpfiction').and_return(13_141)
    # TODO.. how to mock this?
    # MovieHasher.should_receive(:compute_hash)
    expect(@movie.haxx).to eql('0000000000003355')
  end

  it 'should call for size' do
    expect(File).to receive(:size).with('pulpfiction')
    @movie.size
  end

  it 'should generate a beatiful hash for us' do
    expect(Movie::CHUNK_SIZE).to eql(65_536)

    expect(File).to receive(:size).with('onefile').and_return(1020)
    expect(File).to receive(:open).with('onefile', 'rb')

    expect(Movie.new('onefile').haxx).to eql('00000000000003fc')
  end
end
