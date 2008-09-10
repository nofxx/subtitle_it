require 'subtitle_it/formats/srt'
require 'subtitle_it/formats/sub'
require 'subtitle_it/formats/yml'
require 'subtitle_it/formats/rsb'
require 'subtitle_it/formats/xml'
require 'subtitle_it/formats/mpl'

module SubtitleIt
  include Formats
  
  class Subtitle    
    attr_reader :id, :raw, :format, :lines, :style, :info, :filename
    
    EXTS = %w(srt sub smi txt ssa ass mpl xml yml rsb)
    
    def initialize(dump=nil,format=nil,info=nil)
      @info     = info
      @id       = info['IDSubtitleFile'].to_i if info
      @filename = info['SubFileName'].to_s if info
      @format   = info['SubFormat'].to_s if info  
      @fps=23.976      
      parse_dump(dump,format) if dump
    end
    
    def parse_dump(dump,format)
      raise unless format =~ /^srt$|sub|yml|txt|rsb|xml|ass|mpl/
      @raw = dump.kind_of?(String) ? dump : dump.read
      @format = format
      parse!
    end

    def style=(s)
      @style = s
    end
    
    def fps=(fps)
      @fps = fps
    end
    
    def data=(data)
      @raw = data
    end

    
    private
    
    def parse!
      self.lines = send :"parse_#{@format}"      
    end
    
    def lines=(lines)
      @lines = lines
    end  
  end
end