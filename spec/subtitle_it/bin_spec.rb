require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module BinspecHelper
  def mock_xmlrpc(stubs = {})
    @mock_xmlrpc ||= double(XMLRPC::Client, stubs)
  end

  def mock_subdown
    @mock_subdown = double(Subdown)
  end

  def mock_file
    @mock_file = double(File)
  end

  def mock_movie
    @mock_movie = double(Movie, filename: 'Beavis Butthead Do America.avi',
                                haxx: '09a2c497663259cb')
  end

  def mock_subtitle
    @mock_subtitle = double(Subtitle,       :info => sub_info, :format => 'srt', :<=> => 1)
  end

  def sub_info
    {
      'SubLanguageID'   => 'eng',
      'LanguageName'    => 'English',
      'MovieName'       => 'Resevoir Dogs',
      'MovieYear'       => '1992',
      'SubFileName'     => 'Cool sub',
      'MovieFPS'        => '29.0',
      'MovieImdbRating' => '10.0',
      'SubAddDate'      => '12-12-2012 00:01:01',
      'SubDownloadsCnt' => '310',
      'SubRating'       => '9.5',
      'SubFormat'       => 'srt',
      'SubSumCD'        => '2',
      'SubAuthorComment' => 'Nice nice...'
    }
  end
end

describe Bin do
  include BinspecHelper

  it 'should require ARGV' do
    expect { Bin.run!(nil) }.to raise_error RuntimeError
  end

  # Having a hard time testing the command line tool...
  # #
  #
  # it "should call for movie" do
  #   Subdownloader.should_receive(:new)
  #   File.should_receive(:exist?).and_return(true)
  #   File.should_receive(:open).and_return(mock_file)
  #   SubtitleIt::Bin::run!(["movie.avi"])
  # end
  #
  # it "should call for subtitle" do
  #   @subwork_mock = mock(Subwork, :run! => true)#.should_receive(:new)
  #   @subwork_mock.should_receive(:new)
  #   @subwork_mock.should_receive(:run!)
  #   File.should_receive(:exist?).and_return(true)
  #   SubtitleIt::Bin::run!(["movie.srt"])
  # end
end

describe Subdownloader do
  include BinspecHelper

  it 'should print languages' do
    expect(STDOUT).to receive(:puts).at_least(30).times
    SubtitleIt::Bin.print_languages
  end

  it 'should download a subtitle' do
    expect(Movie).to receive(:new).and_return(mock_movie)
    expect(Subdown).to receive(:new).and_return(mock_subdown)

    expect(STDIN).to receive(:gets).and_return('1')
    expect(STDOUT).to receive(:puts).with(/You can choose multiple ones/)
    expect(STDOUT).to receive(:puts).with("Found #{'2'.yellow} results:\n")
    expect(STDOUT).to receive(:print).with(/Choose/)
    expect(STDOUT).to receive(:puts).with("  #{'1'.yellow}. #{'Eng'.green} | #{'SRT'.blue} | #{'Resevoir Dogs'.cyan} / #{'1992'.cyan} | #{'9.5'.yellow} | FPS 29.0 | 2 CDs | 2012-12-12")
    expect(STDOUT).to receive(:puts).with("  #{'2'.yellow}. #{'Eng'.green} | #{'SRT'.blue} | #{'Resevoir Dogs'.cyan} / #{'1992'.cyan} | #{'9.5'.yellow} | FPS 29.0 | 2 CDs | 2012-12-12")
    expect(STDOUT).to receive(:puts).with('Downloading 1 subtitle...')
    expect(STDOUT).to receive(:puts).with('Done: Beavis Butthead Do America.eng.srt'.yellow)

    expect(File).to receive(:open).with('Beavis Butthead Do America.eng.srt', 'w').and_return(true)

    expect(@mock_subdown).to receive(:log_in!).and_return(true)
    expect(@mock_subdown).to receive(:download_subtitle).and_return(mock_subtitle)
    expect(@mock_subdown).to receive(:search_subtitles).and_return([mock_subtitle, mock_subtitle])
    expect(@mock_subdown).to receive(:log_out!).and_return(true)

    Subdownloader.new.run! 'file.avi'
  end

  # it 'should download and convert a subtitle' do
  #   expect(Subtitle).to receive(:new).and_return(mock_subtitle)
  # end

  it 'should get extension files' do
    expect(Bin.get_extension('Lots.of.dots.happen')).to eql('happen')
    expect { Bin.get_extension('Nodotstoo') }.to raise_error RuntimeError
  end

  it 'should swap extensions' do
    expect(Bin.swap_extension('foo.txt', 'srt')).to eql('foo.srt')
  end

  it 'should parse user input' do
    @subd = Subdownloader.new
    expect(@subd.parse_input('1 2-5 7 8-10 15')).to eql([1, 2, 3, 4, 5, 7, 8, 9, 10, 15])
  end

  it 'should print choice' do
    @sub = double(Subtitle, info: sub_info)
    @subd = Subdownloader.new
    expect(@subd.print_option(@sub.info, 1)).
      to eql("  #{'2'.yellow}. #{'Eng'.green} | #{'SRT'.blue} | #{'Resevoir Dogs'.cyan} / #{'1992'.cyan} | #{'9.5'.yellow} | FPS 29.0 | 2 CDs | 2012-12-12")
  end
end

describe Subwork do
  include BinspecHelper

  it 'should call a new subtitle' do
    expect(File).to receive(:open).with('file.srt', 'r').and_return(mock_file)
    expect(File).to receive(:open).with('file.sub', 'w').and_return(true)

    expect(STDOUT).to receive(:puts).with('Working on file file.srt...')
    expect(STDOUT).to receive(:puts).with('Done: file.sub'.yellow)

    expect(Subtitle).to receive(:new).and_return(mock_subtitle)
    expect(@mock_subtitle).to receive(:to_sub).and_return('subbb')

    Subwork.new.run!('file.srt', 'sub')
  end

  it 'should not write if file exist' do
    expect(File).to receive(:open).with('file.srt', 'r').and_return(mock_file)
    expect(File).to receive(:exist?).and_return(true)

    expect(STDOUT).to receive(:puts).with('Working on file file.srt...')
    expect(STDOUT).to receive(:puts).with('File exist: file.sub'.red)

    expect(Subtitle).to receive(:new).and_return(mock_subtitle)
    expect(@mock_subtitle).to receive(:to_sub).and_return('subbb')
    Subwork.new.run!('file.srt', 'sub')
  end
end
