require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module BinspecHelper
  def mock_xmlrpc(stubs={});    @mock_xmlrpc ||= double(XMLRPC::Client, stubs);  end
  def mock_subdown;             @mock_subdown = double(Subdown);  end
  def mock_file;                @mock_file = double(File);  end

  def mock_movie
    @mock_movie = double(Movie, {:filename => "Beavis Butthead Do America.avi",
      :haxx => '09a2c497663259cb' })
  end

  def mock_subtitle
    @mock_subtitle = double(Subtitle, {
      :info => sub_info, :format => 'srt', :<=> => 1
    })
  end

  def sub_info
    {
      "SubLanguageID"   => 'eng',
      "MovieName"       => 'Resevoir Dogs',
      "MovieYear"       => '1992',
      "SubFileName"     => 'Cool sub',
      "MovieImdbRating" => '10.0',
      "SubDownloadsCnt" => '310',
      "SubRating"       => '9.5',
      "SubFormat"       => 'srt',
      "SubSumCD"        => '2',
      "SubAuthorComment" => 'Nice nice...'
      }
  end
end

describe Bin do
  include BinspecHelper

  it "should require ARGV" do
    lambda { Bin::run!(nil) }.should raise_error
  end

  # Having a hard time testing the command line tool...
  # #
  #
  # it "should call for movie" do
  #   Subdownloader.should_receive(:new)
  #   File.should_receive(:exists?).and_return(true)
  #   File.should_receive(:open).and_return(mock_file)
  #   SubtitleIt::Bin::run!(["movie.avi"])
  # end
  #
  # it "should call for subtitle" do
  #   @subwork_mock = mock(Subwork, :run! => true)#.should_receive(:new)
  #   @subwork_mock.should_receive(:new)
  #   @subwork_mock.should_receive(:run!)
  #   File.should_receive(:exists?).and_return(true)
  #   SubtitleIt::Bin::run!(["movie.srt"])
  # end
end

describe Subdownloader do
  include BinspecHelper

  it "should print languages" do
    STDOUT.should_receive(:puts).at_least(30).times
    SubtitleIt::Bin.print_languages
  end

  it "should download a subtitle" do
    Movie.should_receive(:new).and_return(mock_movie)
    Subdown.should_receive(:new).and_return(mock_subdown)
    Subtitle.should_receive(:new).and_return(mock_subtitle)

    STDIN.should_receive(:gets).and_return("1")
    STDOUT.should_receive(:puts).with("You can choose multiple ones, separated with spaces or a range separated with hifen.")
    STDOUT.should_receive(:puts).with("Found #{"2".yellow} results:\n")
    STDOUT.should_receive(:printf).with("Choose: ")
    STDOUT.should_receive(:puts).with("  #{"1".yellow}. #{"Eng".green} | #{"SRT".blue} | #{"Resevoir Dogs".cyan} / #{"1992".cyan} | #{"9.5".yellow} | CDs: 2")
    STDOUT.should_receive(:puts).with("  #{"2".yellow}. #{"Eng".green} | #{"SRT".blue} | #{"Resevoir Dogs".cyan} / #{"1992".cyan} | #{"9.5".yellow} | CDs: 2")
    STDOUT.should_receive(:puts).with("Downloading 1 subtitle...")
    STDOUT.should_receive(:puts).with("Done: Beavis Butthead Do America.srt.".yellow)

    File.should_receive(:open).with("Beavis Butthead Do America.srt", "w").and_return(true)

    @mock_subdown.should_receive(:log_in!).and_return(true)
    @mock_subdown.should_receive(:download_subtitle).and_return(mock_subtitle)
    @mock_subdown.should_receive(:search_subtitles).and_return([mock_subtitle, mock_subtitle])
    @mock_subdown.should_receive(:log_out!).and_return(true)

    Subdownloader.new.run! "file.avi"
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
    @sub = double(Subtitle, :info => sub_info)
      @subd = Subdownloader.new
      @subd.print_option(@sub, 1).should eql("  #{"2".yellow}. #{"Eng".green} | #{"SRT".blue} | #{"Resevoir Dogs".cyan} / #{"1992".cyan} | #{"9.5".yellow} | CDs: 2")
  end
end

describe Subwork do
  include BinspecHelper

  it "should call a new subtitle" do
    File.should_receive(:open).with("file.srt", "r").and_return(mock_file)
    File.should_receive(:open).with("file.sub", "w").and_return(true)

    STDOUT.should_receive(:puts).with("Working on file file.srt...")
    STDOUT.should_receive(:puts).with('Done: file.sub.'.yellow)

    Subtitle.should_receive(:new).and_return(mock_subtitle)
    @mock_subtitle.should_receive(:to_sub).and_return('subbb')

    Subwork.new.run!("file.srt", "sub")
  end

  it "should not write if file exists" do
    File.should_receive(:open).with("file.srt", "r").and_return(mock_file)
    File.should_receive(:exists?).and_return(true)

    STDOUT.should_receive(:puts).with("Working on file file.srt...")
    STDOUT.should_receive(:puts).with("File exists. file.sub".red)

    Subtitle.should_receive(:new).and_return(mock_subtitle)
    @mock_subtitle.should_receive(:to_sub).and_return('subbb')
    Subwork.new.run!("file.srt", "sub")
  end
end
