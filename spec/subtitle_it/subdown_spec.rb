require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subdown do
  before(:each) do
    @down = Subdown.new
    @down.log_in!
    @movie = mock(Movie, :haxx => '09a2c497663259cb')
  end

  
  it "should get imdb info" do
    @movie.should_receive('info=').with({"MovieYear"=>"2004", 
      "MovieImdbID"=>"403358", 
      "MovieName"=>"Nochnoy dozor", 
      "MovieHash"=>"09a2c497663259cb"})
    @down.imdb_info(@movie)
  end
  
  it "should search subs info" do
    @movie.stub!(:size).and_return(733589504)
    res = @down.search_subtitles(@movie)
    res.should be_instance_of(Array)
    res.each do |r| 
      r.should be_instance_of(Subtitle)
    end
  end
  
  

  it "should get subtitle languages" do
    @down.subtitle_languages.should be_nil
  end
  

  
end



# 
# @client.log_in!
# @movie = DownSub::Movie.new('/Users/lundan/Movies/21[2008]DvDrip-aXXo/21[2008]DvDrip-aXXo.avi') # ask_open_file
# @client.imdb_info(@movie)
# 
# puts @client.search_subtitles(@movie).inspect
# 
