require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Formats, ".xml" do
  include SubFixtures
  describe "In" do    
    before(:each) do    
      @xml = Subtitle.new({:dump => xml_fixture, :format => 'xml'}) 
    end  
        
    it "should parse the sub to an array" do
      @xml.lines.should be_instance_of(Array)
    end
    
    it "should have N lines" do
      @xml.should have(13).lines      
    end
    
    it "should parse time of" do
      @xml.lines[0].time_on.to_s.should eql("00:00:00.000")
      @xml.lines[10].time_on.to_s.should eql("00:00:25.520")      
    end
    
    it "should parse time of" do
      @xml.lines[0].time_off.to_s.should eql("00:00:03.700")
      @xml.lines[10].time_off.to_s.should eql("00:00:27.520")        
    end
    
    it "should parse text" do
      @xml.lines[0].text.should eql("I had just joined <span tts:fontSize=\"+2\" tts:fontFamily=\"monospaceSansSerif,proportionalSerif,TheOther\">Macromedia</span> in 1996,")
    end    
  end  
  
  describe "Out" do    
    before(:each) do    
      @sub = Subtitle.new({:dump => yml_fixture, :format => 'yml'})  
    end  
        
    it "should parse the sub to an array" do
      @sub.to_xml.should be_instance_of(String)
    end
     
    it "should equal..." do
      @sub.to_xml.should eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<tt xml:lang=\"en\" xmlns=\"http://www.w3.org/2006/04/ttaf1\"  xmlns:tts=\"http://www.w3.org/2006/04/ttaf1#styling\">
  <head>
    <styling>
    </styling>
  </head>
  <body>
    <div xml:lang=\"en\">
      <p begin=\"00:05:26.500\" dur=\"00:00:02.000\">worth killing for...</p>
      <p begin=\"00:06:00.400\" dur=\"00:00:03.000\">worth dying for...</p>
      <p begin=\"00:07:00.300\" dur=\"00:00:03.000\">worth going to the hell for...</p>
      <p begin=\"00:07:00.300\" dur=\"00:00:03.000\">worth going a | line...</p>
    </div>
  </body>
</tt>")
    end
  end
end