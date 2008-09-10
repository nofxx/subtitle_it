# SubtitleIt
# MPSub, MicroDVD or VOBSub format
#TODO: tricky.. detect which format we got.
#
# {1025}{1115}You always say that.|The same thing every time.
# {1118}{1177}"l'm throug h, never again,|too dangerous."
#
# MicroDVD:
# {1}{1}25.000
# {2447}{2513}You should come to the Drama Club, too.
# {2513}{2594}Yeah. The Drama Club is worried|that you haven't been coming.
# {2603}{2675}I see. Sorry, I'll drop by next time.
#
# Where N is ms / framerate / 1000 (ms -> s)
#
# parts of the code from 'simplesubtitler' from Marcin (tiraeth) Chwedziak 
#
module SubtitleIt
  module Formats
    #between our formats, what changes can be reduced to a value
    def ratio
     1
      
    end
    
       
    def parse_sub
      @raw.to_a.inject([]) do |i,l|
  			line_data = l.scan(/^\{([0-9]{1,})\}\{([0-9]{1,})\}(.+)$/)
  			line_data = line_data.at 0
  			text_on, text_off, text = line_data
  			text_on, text_off = [text_on.to_i, text_off.to_i].map { |t| (t.to_i/@fps*1000).to_i }	    
        i << Subline.new(text_on, text_off, text.chomp)
      end
    end
        
    def to_sub
      @lines.inject([]) do |i,l|
        start = l.text_on.to_i / 1000 * @fps * ratio
        stop = l.text_off.to_i / 1000 * @fps * ratio
        i << "{%d}{%d}%s" % [start, stop, l.text]
      end.join("\r\n")
    end    
  end 
end
