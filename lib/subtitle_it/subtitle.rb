require 'subtitle_it/formats/srt'
require 'subtitle_it/formats/sub'
require 'subtitle_it/formats/yml'
require 'subtitle_it/formats/rsb'

module SubtitleIt
  include Formats
  
  class Subtitle    
    attr_reader :raw, :format, :lines
  
    def initialize(raw,format,framerate=23.976)
      raise unless format =~ /^srt$|^sub|yml|txt|rsb/
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