require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module SubdownHelper
  def mock_xmlrpc(stubs={})
    @mock_xmlrpc ||= mock(XMLRPC::Client, stubs)#, @auth=nil, @parser=nil, @user=nil, @timeout=30, @cookie=nil, @http=#<Net::HTTP www.opensubtitles.org:80 open=false>, @use_ssl=false, @http_last_response=nil, @port=80, @host="www.opensubtitles.org", @path="/xml-rpc", @http_header_extra=nil, @create=nil, @password=nil, @proxy_port=nil, @proxy_host=nil>
  end
  def mock_movie
    @mock_movie = mock(Movie, :haxx => '09a2c497663259cb', :size => 81401)
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
    XMLRPC::Client.should_receive(:new2).with('http://api.opensubtitles.org/xml-rpc').and_return(mock_xmlrpc)
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
    XMLRPC::Client.should_receive(:new2).with('http://api.opensubtitles.org/xml-rpc').and_return(mock_xmlrpc)
    @mock_xmlrpc.should_receive(:call).with("LogIn", "", "", "", "SubtitleIt #{SubtitleIt::VERSION::STRING}").and_return({
      "status"=>"404 FAIL",
      "seconds"=>0.004,
      "token"=>""
      })
    @down = Subdown.new
    lambda { @down.log_in! }.should raise_error
    @down.should_not be_logged_in
  end


  describe "Logged in" do
    before do
      XMLRPC::Client.should_receive(:new2).
        with('http://api.opensubtitles.org/xml-rpc').
        and_return(mock_xmlrpc)

      @mock_xmlrpc.should_receive(:call).with("LogIn", "", "", "",
        "SubtitleIt #{SubtitleIt::VERSION::STRING}").and_return({
          "status"=>"200 OK",
          "seconds"=>0.004,
          "token"=>"shkuj98gcvu5gp1b5tlo8uq525"
      })
      @down = Subdown.new
      @down.log_in!
    end

    it "should search for all languages" do
      @mock_xmlrpc.should_receive(:call).with("SearchSubtitles",
        "shkuj98gcvu5gp1b5tlo8uq525", [{
          "sublanguageid"=>nil,
          "moviebytesize"=>81401,
          "moviehash"=>"09a2c497663259cb"}]).and_return(
            { :result => 200 }
          )

      @down.should_receive(:print).with("Searching for ")
      @down.should_receive(:puts).with("all languages.")
      @down.search_subtitles(mock_movie).should eql([])
    end

    it "should search for one language" do
      @mock_xmlrpc.should_receive(:call).with("SearchSubtitles",
        "shkuj98gcvu5gp1b5tlo8uq525", [{
          "sublanguageid"=>"Portuguese",
          "moviebytesize"=>81401,
          "moviehash"=>"09a2c497663259cb"}]).and_return(
            { :result => 200 }
          )

      @down.should_receive(:print).with("Searching for ")
      @down.should_receive(:puts).with("Portuguese...")
      @down.search_subtitles(mock_movie, "pt").should eql([])
    end

#    it "should get subtitle languages" do
#      @down.subtitle_languages.should be_instance_of(Array)
#      @down.subtitle_languages.length.should eql(51)
#      @down.subtitle_languages[0].should be_instance_of(String)
#    end

  end
end

#  REAL TESTS THAT USES THE WIRE... DUNNO BETTER PRACTICE FOR THIS
#
#   Mock is above, but I`ll keep this here, who knows if
#   Opensubtitle API changes.... any suggestions?
#
# #
# describe Subdown, " - Wired tests" do
#   before(:each) do
#     @down = Subdown.new
#     @movie = mock(Movie, :haxx => '09a2c497663259cb')
#     @down.log_in!
#   end
#
#   it "should get imdb info" do
#     @movie.should_receive('info=').with({"MovieYear"=>"2004",
#       "MovieImdbID"=>"403358",
#       "MovieName"=>"Nochnoy dozor",
#       "MovieHash"=>"09a2c497663259cb"})
#     @down.imdb_info(@movie)
#   end
#
#   it "should search subs info" do
#
#     @movie.stub!(:size).and_return(733589504)
#     res = @down.search_subtitles(@movie, 'pt')
#     res.should be_instance_of(Array)
#     res.each do |r|
#       r.should be_instance_of(Subtitle)
#     end
#   end
# end
