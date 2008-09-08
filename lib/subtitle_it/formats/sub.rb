# SubtitleIt
# MicroDVD  - Subrip format
#
# {1025}{1115}You always say that.|The same thing every time.
# {1118}{1177}"l'm throug h, never again,|too dangerous."
#
# Where N is ms / framerate / 1000 (ms -> s)
#
module SubtitleIt
  module Formats        
    def parse_sub
      @raw.readlines.inject([]) do |i,l|
  			line_data = l.scan(/^\{([0-9]{1,})\}\{([0-9]{1,})\}(.+)$/)
  			line_data = line_data.at 0
  			text_on, text_off, text = line_data
  			text_on, text_off = [text_on.to_i, text_off.to_i].map { |t| (t.to_i/@fps*1000).to_i }	    
        i << Subline.new(text_on, text_off, text.chomp)
      end
    end
        
    def to_sub
      @lines.inject([]) do |i,l|
        start = l.text_on.to_i / @fps / 1000
        stop = l.text_off.to_i / @fps / 1000
        i << "{%d}{%d}%s" % [start, stop, l.text]
      end.join("\r\n")
    end    
  end 
end
