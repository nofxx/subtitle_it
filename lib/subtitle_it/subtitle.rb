module SubtitleIt
  class Subtitle
    attr_reader :raw, :format, :lines
  
    def initialize(raw,format,framerate=23.976)
      raise unless format =~ /srt|sub|yml|txt/
      @framerate = framerate
      @raw = raw
      @format = format
      parse!
    end
    
    def parse!
      self.lines = send :"parse_#{@format}"      
    end
    
    private
    
    def lines=(lines)
      @lines = lines
    end
  
  end
end