require 'subtitle_it/formats/srt'
require 'subtitle_it/formats/sub'
require 'subtitle_it/formats/yml'
require 'subtitle_it/formats/rsb'
require 'subtitle_it/formats/xml'

module SubtitleIt
  include Formats
  
  class Subtitle    
    attr_reader :raw, :format, :lines, :style
    EXTS = %w(srt sub smi txt ssa ass mpl xml yml rsb)
    
    def initialize(dump, format, style=nil, fps=23.976)
      raise unless format =~ /^srt$|^sub|yml|txt|rsb|xml|ass/
      @raw = dump.kind_of?(String) ? dump : dump.read
      @format = format
      @style = style
      @fps = fps      
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