require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module BinspecHelper
  def mock_xmlrpc(stubs={})
    @mock_xmlrpc ||= mock(XMLRPC::Client, stubs)#, @auth=nil, @parser=nil, @user=nil, @timeout=30, @cookie=nil, @http=#<Net::HTTP www.opensubtitles.org:80 open=false>, @use_ssl=false, @http_last_response=nil, @port=80, @host="www.opensubtitles.org", @path="/xml-rpc", @http_header_extra=nil, @create=nil, @password=nil, @proxy_port=nil, @proxy_host=nil> 
  end
  def mock_movie
    @mock_movie = mock(Movie, :haxx => '09a2c497663259cb')
  end
  def mock_subdown
    @mock_subdown = mock(Subdown)
  end
  def mock_subtitle
    @mock_subtitle = mock(Subtitle)
  end  
  def mock_file
    @mock_file = mock(File)
  end
end

describe Bin do
  include BinspecHelper
  
  it "should require ARGV" do
    lambda { Bin::run!(nil) }.should raise_error    
  end
  
  it "should call for movie" do
    Subdownloader.should_receive(:new)
    File.should_receive(:exists?).and_return(true)
    File.should_receive(:open).and_return(mock_file)
    SubtitleIt::Bin::run!(["movie.avi"])
  end
  
  it "should call for subtitle" do
    @subwork_mock = mock(Subwork, :run! => true)#.should_receive(:new)
    @subwork_mock.should_receive(:new)
    @subwork_mock.should_receive(:run!)
    File.should_receive(:exists?).and_return(true)
    SubtitleIt::Bin::run!(["movie.srt"])
  end  
end
  
describe Subdownloader do    

  it "should fetch subtitles" do
    # Movie.should_receive(:new).and_return(mock_movie)
    # File.should_receive(:exists?).and_return(true)
    # File.should_receive(:size).with('file.avi').and_return(1020)
    # File.should_receive(:open).with("file.avi", "rb")   
    # Subdown.should_receive(:new).and_return(mock_subdown)#mock(Subdown)) 
    # @mock_subdown.should_receive(:log_in!)
    # @mock_subdown.should_receive(:search_subtitles).and_return([])
    # 
    # 
    # Subdownloader.new.run! "file.avi"
    
    
  end
  
  it "should get extension files" do
    Bin.get_extension("Lots.of.dots.happen").should eql("happen")
    lambda { Bin.get_extension("Nodotstoo") }.should raise_error
  end
  
  it "should swap extensions" do
    Bin.swap_extension("foo.txt", "srt").should eql("foo.srt")
  end
  
  it "should parse user input" do    
    @subd = Subdownloader.new
    @subd.parse_input("1 2-5 7 8-10 15").should eql([1, 2, 3, 4, 5, 7, 8, 9, 10, 15])    
  end

  it "should print choice" do
    @sub = mock(Subtitle, :info => { 
      "SubLanguageID" => 'eng',
      "MovieName"     => 'Resevoir Dogs',
      "MovieYear"     => '1992',
      "SubFileName"   => 'Cool sub',
      "MovieImdbRating" => '10.0',
      "SubDownloadsCnt" => '310',
      "SubRating"       => '9.5',
      "SubFormat"       => 'srt',
      "SubSumCD"        => '2',
      "SubAuthorComment" => 'Nice nice...'
      })
      @subd = Subdownloader.new
      @subd.print_option(@sub, 1).should eql("2) Resevoir Dogs / 1992 | Cool sub | Movie score: 10.0
   Lang: Eng | Format: SRT | Downloads: 310 | Rating: 9.5 | CDs: 2
   Comments: Nice nice... \n\n")        
  end
end

describe Subwork do
  include BinspecHelper
  
  it "should call a new subtitle" do
    File.should_receive(:open).with("file.srt", "r").and_return(mock_file) 
    File.should_receive(:open).with("file.sub", "w").and_return(true)     

    Subtitle.should_receive(:new).and_return(mock_subtitle)
    @mock_subtitle.should_receive(:to_sub).and_return('subbb')

    Subwork.new.run!("file.srt", "sub")
  end
  
  it "should not write if file exists" do
    File.should_receive(:open).with("file.srt", "r").and_return(mock_file) 
    File.should_receive(:exists?).and_return(true)
    Subtitle.should_receive(:new).and_return(mock_subtitle)
    @mock_subtitle.should_receive(:to_sub).and_return('subbb')
    Subwork.new.run!("file.srt", "sub")
  end
end
