require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MovieHasher do
  it 'should generate a beatiful hash for us' do
    expect(MovieHasher::CHUNK_SIZE).to eql(65_536)

    expect(File).to receive(:size).with('onefile').and_return(1020)
    expect(File).to receive(:open).with('onefile', 'rb')

    expect(MovieHasher.compute_haxx('onefile')).to eql('00000000000003fc')
  end
end
