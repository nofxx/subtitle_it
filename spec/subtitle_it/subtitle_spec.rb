require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subtitle do
  def attr_valid_subtitle  
    { :info => { 
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
    }}
  end
  
  it "should instantiate" do
    @sub = Subtitle.new(attr_valid_subtitle)
    @sub.rating.should eql(9.5)    
  end
  
  it "should fill lines" do
    @sub = Subtitle.new(attr_valid_subtitle.with({:dump => "{10}{20} Hello", :format => "sub"}))
    @sub.lines[0].text.should eql(' Hello')
  end
  
  
  describe "Compare" do
    before(:each) do
      @sub = Subtitle.new(attr_valid_subtitle)
    end    
    
    it "should compare to another using rating" do
      @another_sub = Subtitle.new(attr_valid_subtitle.with(:info => { "SubRating" => 4.0} ))
      (@sub > @another_sub).should be_true
    end      
  end
end
