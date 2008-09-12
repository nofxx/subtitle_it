require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module SubdownHelper
  def mock_xmlrpc(stubs={})
    @mock_xmlrpc ||= mock(XMLRPC::Client, stubs)#, @auth=nil, @parser=nil, @user=nil, @timeout=30, @cookie=nil, @http=#<Net::HTTP www.opensubtitles.org:80 open=false>, @use_ssl=false, @http_last_response=nil, @port=80, @host="www.opensubtitles.org", @path="/xml-rpc", @http_header_extra=nil, @create=nil, @password=nil, @proxy_port=nil, @proxy_host=nil> 
  end
  def mock_movie
    @mock_movie = mock(Movie, :haxx => '09a2c497663259cb')
  end
end


describe Subdown do
  include SubdownHelper
  
  before(:each) do
    @sub = mock(Subtitle)    
  end
  
  it "should initialize nicely" do
    XMLRPC::Client.should_receive(:new2)
    @down = Subdown.new    
  end
  
  it "should log in!" do
    XMLRPC::Client.should_receive(:new2).with('http://www.opensubtitles.org/xml-rpc').and_return(mock_xmlrpc)
    @mock_xmlrpc.should_receive(:call).with("LogIn", "", "", "", "SubtitleIt #{SubtitleIt::VERSION::STRING}").and_return({
      "status"=>"200 OK", 
      "seconds"=>0.004, 
      "token"=>"shkuj98gcvu5gp1b5tlo8uq525"
      })
    @down = Subdown.new
    @down.should_not be_logged_in    
    @down.log_in!
    @down.should be_logged_in
  end
  
  it "should raise if connection sux" do
    XMLRPC::Client.should_receive(:new2).with('http://www.opensubtitles.org/xml-rpc').and_return(mock_xmlrpc)
    @mock_xmlrpc.should_receive(:call).with("LogIn", "", "", "", "SubtitleIt #{SubtitleIt::VERSION::STRING}").and_return({
      "status"=>"404 FAIL", 
      "seconds"=>0.004, 
      "token"=>""
      })
    @down = Subdown.new
    lambda { @down.log_in! }.should raise_error
    @down.should_not be_logged_in
  end


  describe "Instantiate" do
    before(:each) do
      @down = Subdown.new     
    end
    
    it "should get subtitle languages" do
      @down.subtitle_languages.should be_nil
    end
    
    
  end
end

#  REAL TESTS THAT USES THE INTERNET... DUNNO BETTER PRACTICE FOR THIS
#   Mock is nice, but I would like to keep this here, who knows if
#   Opensubtitle API changes.... any suggestions?
#
#describe Subdown, " - Wired tests" do
  # before(:each) do
  #   @down = Subdown.new
  #   @movie = mock(Movie, :haxx => '09a2c497663259cb')
  # end

  # it "should get imdb info" do
  #       @down.log_in!
  #   @movie.should_receive('info=').with({"MovieYear"=>"2004", 
  #     "MovieImdbID"=>"403358", 
  #     "MovieName"=>"Nochnoy dozor", 
  #     "MovieHash"=>"09a2c497663259cb"})
  #   @down.imdb_info(@movie)
  # end
  # 
  # it "should search subs info" do
  #       @down.log_in!
  #   @movie.stub!(:size).and_return(733589504)
  #   res = @down.search_subtitles(@movie)
  #   res.should be_instance_of(Array)
  #   res.each do |r| 
  #     r.should be_instance_of(Subtitle)
  #   end
  # end
# end