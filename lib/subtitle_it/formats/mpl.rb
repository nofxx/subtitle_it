# SubtitleIt
# MPL2 - extension .txt
#
# [1025][1115]You always say that.|The same thing every time.
#
# Where N is sec * 10
#
module SubtitleIt
  module Formats       
    def parse_mpl
      @raw.to_a.inject([]) do |i,l|
  			line_data = l.scan(/^\[([0-9]{1,})\]\[([0-9]{1,})\](.+)$/)
  			line_data = line_data.at 0
  			time_on, time_off, text = line_data
  			time_on, time_off = [time_on.to_i, time_off.to_i].map { |t| t.to_i * 1000 }	    
        i << Subline.new(time_on, time_off, text.chomp)
      end
    end
        
    def to_mpl
      @lines.inject([]) do |i,l|
        start = l.time_on.to_i / 100
        stop = l.time_off.to_i / 100
        i << "[%d][%d]%s" % [start, stop, l.text]
      end.join("\n")
    end    
  end 
end
